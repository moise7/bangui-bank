module Api
  module V1
    class TransactionsController < ApplicationController
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
        end

        render json: { message: 'Transaction successful' }, status: :ok
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      def transaction_params
        params.require(:transaction).permit(:receiver_email, :amount)
      end
    end
  end
end
