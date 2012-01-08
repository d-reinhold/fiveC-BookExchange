# config/environments/staging.rb

FiveCBookExchange::Application.configure do
  config.middleware.insert_after(::Rack::Lock, "::Rack::Auth::Basic", "Staging") do |u, p|
    [u, p] == ['username', 'password']
  end
  
  
  # Set up the mailer with SendGrid
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com'
  }
  ActionMailer::Base.delivery_method = :smtp

  #... other config
end
