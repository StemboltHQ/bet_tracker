class ExpiryDateValidator < ActiveModel::Validator
  def validate(record)
    return unless record.expires_at && record.expires_at <= DateTime.current
    record.errors[:expires_at] << 'date must be in the future'
  end
end
