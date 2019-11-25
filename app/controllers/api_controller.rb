class ApiController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Serialization
  protect_from_forgery unless: -> { request.format.json? }
  prepend_before_action :restrict_access

  def show_incidences_historical
    render json: {entries: Incidence.find_by_sql(["SELECT inc.id, inc.image_url, inc.description, inc.latitude, inc.longitude, inc.created_at, it.status, ityp.name
                                                   FROM incidences inc, (SELECT id, status, date, incidence_id
                                                                         FROM incidence_trackings it1
                                                                         WHERE date = (SELECT MAX(date)
                                                                                       FROM incidence_trackings it2
                                                                                       WHERE it1.incidence_id = it2.incidence_id)
                                                                         UNION ALL
                                                                         SELECT DISTINCT CAST(NULL AS bigint) as id, 1 as status, CAST(NULL AS timestamp) as date, inc.id as incidence_id
                                                                         FROM incidence_trackings it, incidences inc
                                                                         WHERE inc.id != it.incidence_id AND NOT EXISTS(SELECT id FROM incidence_trackings
                                                                                                                        WHERE incidence_id = inc.id)) it, incidence_types ityp
                                                   WHERE inc.id = it.incidence_id
                                                   AND inc.incidence_type_id = ityp.id
                                                   AND inc.phone_identifier_id = ?", PhoneIdentifier.find(params[:id]).id])}
  end

  def post_incidences
    @incidence = Incidence.new(incidence_params)
    @incidence.save
    @incidence.image_url = rails_blob_path(@incidence.picture, only_path: true) if @incidence.picture.attached?
    @incidence.save
    render json: @incidence
  end

  private

  def incidence_params
    params.permit(:description, :picture, :phone_identifier_id, :latitude, :longitude, :incidence_type_id)
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, _options|
      @api_key = Apicasso::Key.find_by(token: token)
    end
  end

end