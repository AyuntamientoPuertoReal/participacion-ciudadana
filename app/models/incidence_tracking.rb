class IncidenceTracking < ApplicationRecord
  belongs_to :incidence
  belongs_to :staff

  validates :description, presence: { message: I18n.t("error_messages.blank_field")}
  validates :description, length: {minimum: 10, message: I18n.t("error_messages.minimum", deep_interpolation: true, min: "10")}
end
