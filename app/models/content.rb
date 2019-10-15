class Content < ApplicationRecord
  belongs_to :author
  belongs_to :editor
  belongs_to :base_instance
  belongs_to :previous_instance
  belongs_to :web_section
end
