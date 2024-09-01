class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def create
    receiver = User.find_by(email: transaction_params[:receiver_email])
    if receiver.nil?
      render json: { error: "Receiver not found" }, status: :not_found
      return
    end

    # Log the sender's balance for debugging
    Rails.logger.info "Transferring #{transaction_params[:amount]} from #{current_user.email} (balance: #{current_user.balance}) to #{receiver.email} (balance: #{receiver.balance})"

    begin
      current_user.transfer_money_to(receiver, transaction_params[:amount].to_d)
      render json: { message: "Transfer successful" }, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end



  private

  def transaction_params
    params.require(:transaction).permit(:receiver_email, :amount)
  end
end
