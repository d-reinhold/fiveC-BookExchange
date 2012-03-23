class RequestMailer < ActionMailer::Base
  default from: "5C Book Exchange <fivecbookexchange@sendgrid.me>"
  
  def request_available(request, book)
    @book = book
    @date = request.created_at
    @email = request.user.email
    @name = request.user.name
    @url  = "http://www.5cbookexchange.com"
    email_with_name = "#{@name} <#{@email}>"
    mail(:to => email_with_name, :subject => "A book you requested is available!")
    #mail(:to => 'check-auth2@verifier.port25.com', :subject => "Welcome to the 5C Book Exchange!")  
  end
  
  
  
  
end
