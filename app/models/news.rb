class News < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :author_id, class_name: "Staff"
  belongs_to :editor_id, class_name: "Staff"
end
