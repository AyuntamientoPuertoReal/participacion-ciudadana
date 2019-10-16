class IncidenceTracking < ApplicationRecord
  belongs_to :incidence
  belongs_to :staff
end
