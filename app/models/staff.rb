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

    if code || name || ut
      if !(code.blank?)
          hash_where["code_str"] = "lower(username) LIKE " + "'%#{code.strip.downcase}%'"
      end
      
      if !(name.blank?)
          hash_where["name_str"] = "lower(full_name) LIKE " + "'%#{name.strip.downcase}%'"
      end

      if ut != "0"  
        pu_staff_query = PuStaff.where(:processing_unit_id => ut).select(:staff_id)
        pu_staff_ids = ""
        
        pu_staff_query.each do |staff_pu|
          if pu_staff_ids.blank?
            pu_staff_ids = staff_pu.staff_id.to_s
          else
            pu_staff_ids += ", " + staff_pu.staff_id.to_s
          end
        end
        puts pu_staff_ids
        if !(pu_staff_ids.blank?)
          hash_where["ut_str"] = "id IN (" + "#{pu_staff_ids}" + ")"
        else
          hash_where["ut_str"] = "id IS NULL"
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

end
