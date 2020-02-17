class IncidenceType < ApplicationRecord
  has_many :pu_it
  has_many :processing_unit, through: :pu_it, class_name: 'PuIt'

  validates :name, :code, :description, presence: { message: I18n.t("error_messages.blank_field")}
  validates :code, uniqueness: { message: I18n.t("error_messages.not_unique") }
  validates :description, length: {maximum: 250, message: I18n.t("error_messages.maximum", deep_interpolation: true, max: "250")}
  validates :description, length: {minimum: 10, message: I18n.t("error_messages.minimum", deep_interpolation: true, min: "10")}
end
