class Api::V1::PaymentsController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def create
    sender = current_user
    receiver = User.find_by(email: payment_params[:receiver_email])

    if receiver.nil?
      return render json: { error: 'Receiver not found' }, status: :not_found
    end

    if sender.balance < payment_params[:amount].to_f
      return render json: { error: 'Insufficient funds' }, status: :unprocessable_entity
    end

    # Update sender's balance
    sender.update!(balance: sender.balance - payment_params[:amount].to_f)

    # Update receiver's balance
    receiver.update!(balance: receiver.balance + payment_params[:amount].to_f)

    # Create the payment record
    Payment.create!(
      user_id: sender.id,
      recipient_id: receiver.id,
      amount: payment_params[:amount].to_f,
      description: payment_params[:description]
    )

    # Send email notification
    send_notification(sender, receiver, payment_params[:amount].to_f)

    render json: { message: 'Payment successful', balance: sender.balance }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    # Fetch payments for the current user
    payments = Payment.where(user_id: current_user.id)

    payments_with_recipient = payments.map do |payment|
      recipient = User.find_by(id: payment.recipient_id)
      {
        id: payment.id,
        amount: payment.amount,
        description: payment.description,
        user_id: payment.user_id,
        created_at: payment.created_at,
        updated_at: payment.updated_at,
        recipient_first_name: recipient&.first_name,
        recipient_last_name: recipient&.last_name
      }
    end

    render json: { payments: payments_with_recipient }
  end

  private

  def payment_params
    params.require(:payment).permit(:receiver_email, :amount, :description)
  end

  def send_notification(sender, receiver, amount)
    message = "Payment Successful: You sent $#{amount} to #{receiver.email}. Your remaining balance is $#{sender.balance}."

    SendGridClient.new.send_email(
      from: 'marketingmoise@gmail.com',
      to: sender.email,
      subject: 'Payment Notification',
      content: message
    )
  end
end
