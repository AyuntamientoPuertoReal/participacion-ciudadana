class AttachedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "no adjunta", options) unless value.attached?
  end
end