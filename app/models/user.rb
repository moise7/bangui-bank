class User < ApplicationRecord
  has_many :transactions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, authentication_keys: [:username],
         jwt_revocation_strategy: JwtDenylist

  # Validations
  validates :first_name, :middle_name, :last_name, :date_of_birth, :town, :country, presence: true
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

  def transfer_money_to(receiver, amount)
    ActiveRecord::Base.transaction do
      # Deduct from sender
      self.balance -= amount
      save!

      # Add to receiver
      receiver.balance += amount
      receiver.save!

      # Create transaction record (optional)
      Transaction.create!(
        sender_id: self.id,
        receiver_id: receiver.id,
        amount: amount
      )
    end
  end

  private

  def generate_jti
    self.jti ||= SecureRandom.uuid
  end
end

