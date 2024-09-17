class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_user! # Ensure the user is authenticated

  def create
    sender = current_user
    receiver = User.find_by(email: transaction_params[:receiver_email])

    if receiver.nil?
      return render json: { error: 'Receiver not found' }, status: :not_found
    end

    if sender.balance < transaction_params[:amount].to_f
      return render json: { error: 'Insufficient funds' }, status: :unprocessable_entity
    end

    ActiveRecord::Base.transaction do
      # Deduct the amount from the sender's balance
      sender.update!(balance: sender.balance - transaction_params[:amount].to_f)
      # Add the amount to the receiver's balance
      receiver.update!(balance: receiver.balance + transaction_params[:amount].to_f)

      # Send SMS notification to the sender about the transaction
      send_notification(sender, receiver, transaction_params[:amount].to_f)
    end

    render json: { message: 'Transaction successful', balance: sender.balance }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def transaction_params
    params.require(:transaction).permit(:receiver_email, :amount)
  end

  def send_notification(sender, receiver, amount)
    message = "Transaction Successful: You sent $#{amount} to #{receiver.email}. Your remaining balance is $#{sender.balance}."

    # Make sure the sender has a phone number
    if sender.phone_number.present?
      # Twilio notification (assuming you have Twilio set up)
      TwilioClient.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],  # Twilio number from your account
        to: sender.phone_number,  # The sender's phone number
        body: message
      )
    else
      Rails.logger.warn "User #{sender.email} has no phone number. Notification not sent."
    end
  end
end
