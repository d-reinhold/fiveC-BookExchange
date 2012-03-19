Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '274758929266415', 'b740a6e6a52c11d9477d061c79f430dd',
  :scope => 'email,user_education_history, offline_access', :display => 'popup'
end