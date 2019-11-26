class PuStaff < ApplicationRecord
  belongs_to :staff
  belongs_to :processing_unit
end
