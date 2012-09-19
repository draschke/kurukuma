Rails.application.config.middleware.use OmniAuth::Builder do
  key = ENV['TW_CONSUMER_KEY'] || Settings.twitter.consumer_key
  secret = ENV['TW_CONSUMER_SECRET'] || Settings.twitter.consumer_secret
  provider :twitter, key, secret
end
