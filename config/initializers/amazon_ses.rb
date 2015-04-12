ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  server: 'email-smtp.us-east-1.amazonaws.com'
  access_key_id: ENV['AMAZON_ACCESS_KEY'],
  secret_access_key: ENV['AMAZON_SECRET_KEY']
