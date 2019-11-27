class News < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :author, class_name: "Staff"
  belongs_to :last_editor, class_name: "Staff", optional: true
end