class Content < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :staff
  belongs_to :base_instance, class_name: "Content", optional: true
  belongs_to :previous_instance, class_name: "Content", optional: true
  belongs_to :web_section, optional: true

  has_many :children, class_name: "Content", foreign_key: "base_instance"
  has_one :next_instance, class_name: "Content", foreign_key: "previous_instance"
end
