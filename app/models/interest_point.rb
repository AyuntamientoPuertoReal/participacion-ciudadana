class InterestPoint < ApplicationRecord

  validates :name, :latitude, :longitude, :description, :image_url, presence: { message: I18n.t("error_messages.blank_field")}
  validates :name, length: {maximum: 100, message: I18n.t("error_messages.maximum", deep_interpolation: true, max: "100")}
  validates :description, length: {maximum: 250, message: I18n.t("error_messages.maximum", deep_interpolation: true, max: "250")}
  validates :description, length: {minimum: 10, message: I18n.t("error_messages.minimum", deep_interpolation: true, min: "10")}

  def self.search(name)
    hash_where = {"name_str" => ""}
    string_where = ""

    if name
      if !(name.blank?)
        hash_where["name_str"] = "lower(name) LIKE " + "'%#{name.strip.downcase}%'"
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
