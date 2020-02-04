class Incidence < ApplicationRecord
  belongs_to :phone_identifier
  belongs_to :incidence_type, optional: true

  has_many :incidence_tracking
  has_one_attached :picture

  def self.search(description, type, from, to)
    dual_date = false
    hash_where = {"description_str" => "", "type_str" => "", "from_str" => "", "to_str" => "", "dual_date_str" => ""}
    string_where = ""

    if description || type || from || to
      if !(description.blank?)
        hash_where["description_str"] = "lower(description) LIKE " + "'%#{description.strip.downcase}%'"
      end

      if type != "0"  
        pu_it_query = Incidence.where(:incidence_type_id => type).select(:id)
        pu_it_ids = ""
        
        pu_it_query.each do |it_pu|
          if pu_it_ids.blank?
            pu_it_ids = it_pu.id.to_s
          else
            pu_it_ids += ", " + it_pu.id.to_s
          end
        end

        if !(pu_it_ids.blank?)
          hash_where["type_str"] = "id IN (" + "#{pu_it_ids}" + ")"
        else
          hash_where["type_str"] = "id IS NULL"
        end
      end
      
      if !(from.blank?) && !(to.blank?)
        hash_where["dual_date_str"] = "date(created_at) BETWEEN '" + from + "' AND '" + to + "'"
        dual_date = true
      end

      if !(from.blank?) && !(dual_date)
        hash_where["from_str"] = "date(created_at) >= '" + from + "'"
      end
      
      if !(to.blank?) && !(dual_date)
          hash_where["to_str"] = "date(created_at) <= '" + to + "'"
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
