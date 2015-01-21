class CandeoMailer < ActionMailer::Base
  default from: "gamealoon@gmail.com" #For testing... in prod this will change to no-reply@candeoapp.com

  def verify_user(user, url)  	  	
  	@user =user
  	@url=url
  	mail(to:user.email, subject:"Welcome To Candeo")
  end	
end
