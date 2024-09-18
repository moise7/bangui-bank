# controllers/send-email.rb
require 'sendgrid-ruby'
include SendGrid

from = SendGrid::Email.new(email: 'marketingmoise@gmail.com')
to = SendGrid::Email.new(email: 'watibonheur@gmail.com')
subject = 'Testing '
content = SendGrid::Content.new(type: 'text/plain', value: 'Testing')
mail = SendGrid::Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: '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')

begin
  response = sg.client.mail._('send').post(request_body: mail.to_json)

  puts response.status_code
  puts response.body
  puts response.headers
rescue StandardError => e
  puts "Error occurred: #{e.message}"
end
