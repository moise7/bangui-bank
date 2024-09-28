class Payment < ApplicationRecord
  belongs_to :user # User who made the payment
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id' # Associate recipient with User model

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
end
