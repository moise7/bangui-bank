# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: 'marketingmoise@gmail.com'

  def payment_email(user, amount)
    @user = user
    @amount = amount
    mail(to: @user.email, subject: 'Payment Confirmation')
  end
end
