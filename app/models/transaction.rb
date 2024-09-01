class Transaction < ApplicationRecord
  # Associations
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
