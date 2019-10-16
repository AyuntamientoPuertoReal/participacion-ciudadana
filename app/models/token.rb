class Token < ApplicationRecord
  has_many :incidence, optional: true
end
