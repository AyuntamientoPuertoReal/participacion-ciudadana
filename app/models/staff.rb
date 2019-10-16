class Staff < ApplicationRecord
  has_many :pu_staff
  has_many :processing_units, through: :pu_staff
  has_many :incidence_tracking, optional: true
  has_many :content, optional: true
end
