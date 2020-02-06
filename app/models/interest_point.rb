class InterestPoint < ApplicationRecord

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
