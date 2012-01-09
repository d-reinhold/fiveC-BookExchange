class UserMailer < ActionMailer::Base
  default from: "5C Book Exchange <fivecbookexchange@sendgrid.me>"
  
  def welcome_email(user)
    @user = user
    @url  = "http://www.5cbookexchange.com"
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "Welcome to the 5C Book Exchange!")
    #mail(:to => 'check-auth2@verifier.port25.com', :subject => "Welcome to the 5C Book Exchange!")
    
  end
  
  
  
  
end
