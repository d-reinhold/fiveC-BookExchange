Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, '305172996219867', '5e4b3054221c2e932717121fe9d63f84',
             :scope => 'email,user_education_history, offline_access', 
             :display => 'popup'
  elsif Rails.env.staging?
    provider :facebook, '332717666783440', 'e822193f338a08240d58f14d2b249006',
             :scope => 'email,user_education_history, offline_access', 
             :display => 'popup'    
  elsif Rails.env.development?
    provider :facebook, '274758929266415', 'b740a6e6a52c11d9477d061c79f430dd',
             :scope => 'email,user_education_history, offline_access', 
             :display => 'popup'  
  end
end