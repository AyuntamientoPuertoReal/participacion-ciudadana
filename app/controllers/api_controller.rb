class ApiController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  prepend_before_action :restrict_access

  Apicasso::Key.create(scope:
                           { read:
                                 {
                                   incidence: true,
                                   phone_identifier: true,
                                   interest_point: true,
                                   incidence_type: true,
                                   incidence_tracking: true
                                 },
                             create:
                                 {
                                   incidence: true,
                                   phone_identifier: true
                                 }
                           })


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

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, _options|
      @api_key = Apicasso::Key.find_by(token: token)
    end
  end

end

