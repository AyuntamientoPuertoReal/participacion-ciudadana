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

  def self.search(code, name, ut)
    hash_where = {"code_str" => "", "name_str" => "", "ut_str" => ""}
    string_where = ""

    if code || name || ut != "Ninguno"
      if code
        if code != ""
          hash_where["code_str"] = "lower(username) LIKE " + "'%#{code.strip.downcase}%'"
        end
      end
      if name
        if name != ""
          hash_where["name_str"] = "lower(full_name) LIKE " + "'%#{name.strip.downcase}%'"
        end
      end
      if ut
        if ut != "Ninguno"
          hash_where["ut_str"] = ""
        end
      end

      hash_where.values.each do |valor|
          if valor != ""
            if string_where != ""
              string_where = string_where + " AND " + valor
            else
              string_where = valor
            end
          end
      end

      where(string_where)
    else
      all
    end
  end

  def self.search_name(search)
    if search
      where('lower(code) LIKE ?', "%#{search.strip.downcase}%")
    else
      all
    end
  end

  def self.search_ut(search)
    if search
      where('lower(ut) LIKE ?', "%#{search.strip.downcase}%")
    else
      all
    end
  end
end
