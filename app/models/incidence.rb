class Incidence < ApplicationRecord
  belongs_to :phone_identifier
  belongs_to :incidence_type, optional: true

  has_many :incidence_tracking
  has_one_attached :picture

end
