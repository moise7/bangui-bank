require 'twilio-ruby'

class TwilioClient
  def initialize
    credentials = Rails.application.credentials.twilio
    @client = Twilio::REST::Client.new(credentials[:account_sid], credentials[:auth_token])
  end

  def send_message(phone_number, message)
    message = @client.messages.create(
      from: Rails.application.credentials.twilio[:phone_number],
      to: phone_number,
      body: message
    )
    message.sid
  end

  def check_message_status(message_sid)
    message = @client.messages(message_sid).fetch
    message.status
  end
end

# Example usage
twilio_client = TwilioClient.new
message_sid = twilio_client.send_message('+15743717590', 'Hello, this is a test message from Twilio!')
puts "Message SID: #{message_sid}"

status = twilio_client.check_message_status(message_sid)
puts "Message status: #{status}"
