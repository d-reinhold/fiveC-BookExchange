class UserMailer < ActionMailer::Base
  default from: "FiveCBookExchange@gmail.com"
  
  
  def welcome_email(user)
    @user = user
    @url  = "http://five-c-book-exchange.herokuapp.com/signin"
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "Welcome to the 5C Book Exchange!")
  end
  
  
  
  
end
