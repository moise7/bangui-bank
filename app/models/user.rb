class User < ApplicationRecord
  # Associations
  has_many :payments

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, authentication_keys: [:username],
         jwt_revocation_strategy: JwtDenylist

  # Validations
  validates :first_name, :middle_name, :last_name, :date_of_birth, :town, :country, presence: true
  validates :username, presence: true, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :age_must_be_18_or_older

  # Callbacks
  before_create :set_default_balance
  before_create :generate_jti

  # Override this method to authenticate users using username instead of email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (username = conditions.delete(:username))
      where(conditions).where(["lower(username) = :value", { value: username.downcase }]).first
    end
  end

  # Method to deposit funds
  def deposit(amount)
    raise "Amount must be positive" if amount <= 0
    update!(balance: (balance || 0) + amount)
  end

  # Method to transfer money
  def transfer_money_to(receiver, amount)
    ActiveRecord::Base.payment do
      raise "Insufficient funds" if balance < amount
      self.balance = (balance || 0) - amount
      save!

      receiver.balance = (receiver.balance || 0) + amount
      receiver.save!

      # Create payment record (optional)
      Payment.create!(
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

  def age_must_be_18_or_older
    if date_of_birth.present? && (Date.today.year - date_of_birth.year) < 18
      errors.add(:date_of_birth, 'You must be 18 or older to sign up.')
    end
  end

  def set_default_balance
    self.balance ||= 0.0
  end
end
