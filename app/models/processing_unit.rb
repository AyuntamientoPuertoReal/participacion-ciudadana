class ProcessingUnit < ApplicationRecord
  has_many :pu_it
  has_many :incidence_type, through: :pu_it
  has_many :pu_ws
  has_many :web_section, through: :pu_ws
  has_many :pu_staff
  has_many :staff, through: :pu_staff
end
