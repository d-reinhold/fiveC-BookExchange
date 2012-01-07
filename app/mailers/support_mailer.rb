class SupportMailer < ActionMailer::Base
  default from: "5C Book Exchange <fivecbookexchange@sendgrid.me>"
  default :to => "d.reinhold@yahoo.com"

  def support_message(message)
    @message = message
    mail(:subject => "New Support Message from the 5C Book Exchange")

  end




end
