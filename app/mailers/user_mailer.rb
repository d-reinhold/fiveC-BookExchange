class UserMailer < ActionMailer::Base
  default from: "5C Book Exchange <fivecbookexchange@gmail.com>"
  
  def welcome_email(user)
    @user = user
    @url  = "http://fivecbookexchange.herokuapp.com"
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "Welcome to the 5C Book Exchange!")
  end
  
  
  
  
end
