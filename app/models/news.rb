class News < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :author, class_name: "Staff"
  belongs_to :last_editor, class_name: "Staff", optional: true

  def self.search(title, author, created_at, published)
    hash_where = {"title_str" => "", "author_str" => "", "created_at_str" => "", "published_str" => ""}
    string_where = ""

    if title || author || created_at || published != "0"
      if !(title.blank?)
          hash_where["title_str"] = "lower(title) LIKE " + "'%#{title.strip.downcase}%'"
      end

      if !(author.blank?)
          author_id_query = Staff.where("lower(full_name) LIKE " + "'%#{author.strip.downcase}%'").select(:id)
          autor_id_ids = ""
          author_id_query.each do |id_author|
            if autor_id_ids.blank?
              autor_id_ids = id_author.id.to_s
            else
              autor_id_ids += ", " + id_author.id.to_s
            end
          end

          if !(autor_id_ids.blank?) 
            hash_where["author_str"] = "author_id IN (" + "#{autor_id_ids}" + ")"
          else
            hash_where["author_str"] = "author_id IS NULL"
          end
      end
      
      if !(created_at.blank?)
          hash_where["ut_str"] = ""
      end

      if published != "0"
        if published == "1"
          hash_where["published_str"] = "published = true"
        end
        if published == "2"
          hash_where["published_str"] = "published = false"
        end
      end

      hash_where.values.each do |valor|
          if !(valor.blank?)
            if !(string_where.blank?)
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