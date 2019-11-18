class ProcessingUnit < ApplicationRecord
  has_many :pu_it
  has_many :incidence_type, through: :pu_it, class_name: 'PuIt'
  has_many :pu_staff
  has_many :staff, through: :pu_staff, class_name: 'PuStaff'
end
