class ProcessingUnit < ApplicationRecord
  has_many :pu_it
  has_many :incidence_type, through: :pu_it, class_name: 'PuIt'
  has_many :pu_staff
  has_many :staff, through: :pu_staff, class_name: 'PuStaff'

  validates :code, :description, presence: { message: I18n.t("error_messages.blank_field")}
  validates :code, uniqueness: { message: I18n.t("error_messages.not_unique") }
  validates :description, length: {maximum: 250, message: I18n.t("error_messages.maximum", deep_interpolation: true, max: "250")}
  validates :description, length: {minimum: 10, message: I18n.t("error_messages.minimum", deep_interpolation: true, min: "10")}

  def self.search(code, description)
    hash_where = {"code_str" => "", "description_str" => ""}
    string_where = ""

    if code || description
      if !(code.blank?)
        hash_where["code_str"] = "lower(code) LIKE " + "'%#{code.strip.downcase}%'"
      end

      if !(description.blank?)
        hash_where["description_str"] = "lower(description) LIKE " + "'%#{description.strip.downcase}%'"
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
