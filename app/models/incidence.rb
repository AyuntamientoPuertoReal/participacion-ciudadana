class Incidence < ApplicationRecord
  belongs_to :token
  belongs_to :incidence_type
end
