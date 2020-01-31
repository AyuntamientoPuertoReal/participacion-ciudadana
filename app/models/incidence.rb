class Incidence < ApplicationRecord
  belongs_to :phone_identifier
  belongs_to :incidence_type, optional: true

  has_many :incidence_tracking
  has_one_attached :picture

  def self.search_date(desde, hasta)
    if desde
      where('created_at >= ?', "#{desde.strip}")
    elsif desde and hasta
      where(created_at: desde..hasta)
    elsif hasta
      where('created_at <= ?', "#{hasta.strip}")
    else
      all
    end
  end

end
