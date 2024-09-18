require 'sendgrid-ruby'
include SendGrid

class SendGridClient
  def initialize
    @client = SendGrid::API.new(api_key: Rails.application.credentials.sendgrid[:api_key])
  end

  def send_email(from:, to:, subject:, content:)
    from_email = SendGrid::Email.new(email: from)
    to_email = SendGrid::Email.new(email: to)
    content = SendGrid::Content.new(type: 'text/plain', value: content)
    mail = SendGrid::Mail.new(from_email, subject, to_email, content)

    response = @client.client.mail._('send').post(request_body: mail.to_json)

    if response.status_code.to_i >= 400
      Rails.logger.error "Failed to send email: #{response.body}"
    else
      Rails.logger.info "Email sent successfully. Status code: #{response.status_code}"
    end
  rescue StandardError => e
    Rails.logger.error "Error occurred while sending email: #{e.message}"
  end
end
