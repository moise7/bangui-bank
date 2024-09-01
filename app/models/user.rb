class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

   # Add username validation
   validates :username, presence: true, uniqueness: true

  # Associations
  has_many :sent_bank_transactions, class_name: 'BankTransaction', foreign_key: 'sender_id'
  has_many :received_bank_transactions, class_name: 'BankTransaction', foreign_key: 'receiver_id'

  # Validations
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Transfer money to another user
  def transfer_money_to(receiver, amount)
    raise "Insufficient funds" if self.balance < amount

    ActiveRecord::Base.transaction do
      self.update!(balance: self.balance - amount)
      receiver.update!(balance: receiver.balance + amount)
      Transaction.create!(sender_id: self.id, receiver_id: receiver.id, amount: amount)
      send_notification_to(receiver)
    end
  end
    # Add a method to deposit funds
    def deposit(amount)
      raise "Amount must be positive" if amount <= 0
      update!(balance: self.balance + amount)
    end

  private

  def send_notification_to(user)
    TwilioClient.new.send_message(user.phone_number, "You've received $#{amount} from #{self.email}")
  end
end