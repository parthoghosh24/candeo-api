class CandeoMailer < ActionMailer::Base
  default from: "gamealoon@gmail.com" #For testing... in prod this will change to no-reply@candeoapp.com

  def verify_user(user, url)  	
  	body = "<!DOCTYPE html>
				<html>
				<head>
				</head>
				<body>
				  <p>Hey #{user.name},</p>

				  <p> Welcome to Candeo. To continue login, please click the below button</p>
				  <p><a href='#{url}'style='background: #4193d0;border-color: #4193d0;color: #fff;display:inline-block;text-align:center;'>Continue to login</a></p>					  
				</body>
				</html>"
  	mail(to:user.email, subject:"Welcome To Candeo", body:body)
  end	
end
