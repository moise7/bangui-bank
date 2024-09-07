# class User < ApplicationRecord
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable,
#          :jwt_authenticatable, authentication_keys: [:username],
#          jwt_revocation_strategy: JwtDenylist

#   # Add username validation
#   validates :username, presence: true, uniqueness: true

#   # Associations
#   has_many :sent_bank_transactions, class_name: 'BankTransaction', foreign_key: 'sender_id'
#   has_many :received_bank_transactions, class_name: 'BankTransaction', foreign_key: 'receiver_id'

#   # Validations
#   validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

#   # Ensure a jti is generated for JWT authentication
#   before_create :generate_jti

#   # Transfer money to another user
#   def transfer_money_to(receiver, amount)
#     raise "Insufficient funds" if balance < amount

#     ActiveRecord::Base.transaction do
#       update!(balance: balance - amount)
#       receiver.update!(balance: receiver.balance + amount)
#       Transaction.create!(sender_id: id, receiver_id: receiver.id, amount: amount)
#       send_notification_to(receiver, amount)
#     end
#   end

#   # Add a method to deposit funds
#   def deposit(amount)
#     raise "Amount must be positive" if amount <= 0
#     update!(balance: balance + amount)
#   end

#   private

#   def send_notification_to(user, amount)
#     TwilioClient.new.send_message(user.phone_number, "You've received $#{amount} from #{email}")
#   end

#   def generate_jti
#     self.jti ||= SecureRandom.uuid
#   end
# end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, authentication_keys: [:username],
         jwt_revocation_strategy: JwtDenylist

  # Add username validation
  validates :username, presence: true, uniqueness: true

  # Ensure a jti is generated for JWT authentication
  before_create :generate_jti

  # Override this method to authenticate users using username instead of email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (username = conditions.delete(:username))
      where(conditions).where(["lower(username) = :value", { value: username.downcase }]).first
    end
  end

  # Add a method to deposit funds (example)
  def deposit(amount)
    raise "Amount must be positive" if amount <= 0
    update!(balance: balance + amount)
  end

  private

  def generate_jti
    self.jti ||= SecureRandom.uuid
  end
end

