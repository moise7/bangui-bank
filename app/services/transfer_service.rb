class TransferService
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def call
    ActiveRecord::Base.payment do
      @sender.update!(balance: @sender.balance - @amount)
      @receiver.update!(balance: @receiver.balance + @amount)
      BankTransaction.create!(sender: @sender, receiver: @receiver, amount: @amount)
      TwilioClient.new.send_message(@receiver.phone_number, "You've received $#{@amount} from #{@sender.email}")
    end
  rescue StandardError => e
      raise e
  end
end
