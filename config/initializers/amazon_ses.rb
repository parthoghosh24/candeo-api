ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  :server=> 'email-smtp.us-east-1.amazonaws.com',
  :access_key_id=> SES_CONF['api_key'],
  :secret_access_key=> SES_CONF['api_secret']
