Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  # provider :facebook, '343128102712351', '370bc21cd83c1271b9ed2ccbf61ef51d'
end
