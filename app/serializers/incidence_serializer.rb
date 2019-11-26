class IncidenceSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :description, :picture, :phone_identifier_id, :latitude, :longitude, :incidence_type_id, :created_at

  def picture
    rails_blob_path(object.picture, only_path: true) if object.picture.attached?
  end

end
