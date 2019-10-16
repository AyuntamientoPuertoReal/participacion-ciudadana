class Incidence < ApplicationRecord
  belongs_to :token
  belongs_to :incidence_type, optional: true

  has_many :incidence_tracking
end
