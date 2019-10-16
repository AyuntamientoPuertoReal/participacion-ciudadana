class WebSection < ApplicationRecord
  has_many :pu_ws
  has_many :processing_units, through: :pu_ws
  has_many :content
end
