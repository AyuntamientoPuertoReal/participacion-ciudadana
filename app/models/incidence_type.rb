class IncidenceType < ApplicationRecord
  has_many :pu_it
  has_many :processing_unit, through: :pu_it, class_name: 'PuIt'
end
