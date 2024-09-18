class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_user!

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
      sender.update!(balance: sender.balance - transaction_params[:amount].to_f)
      receiver.update!(balance: receiver.balance + transaction_params[:amount].to_f)

      # Send email notification
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

    SendGridClient.new.send_email(
      from: 'marketingmoise@gmail.com',
      to: sender.email,
      subject: 'Transaction Notification',
      content: message
    )
  end
end
