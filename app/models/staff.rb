class Staff < ApplicationRecord
  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :registerable eliminado.
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :pu_staff
  has_many :processing_units, through: :pu_staff, class_name: 'PuStaff'
  has_many :incidence_tracking
  has_many :created_news, class_name: "News", foreign_key: "author_id"
  has_many :edited_news, class_name: "News", foreign_key: "editor_id"
  belongs_to :role, optional: true

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  def self.search(search)
    if search
      where('lower(username) LIKE ? OR upper(username) LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end
