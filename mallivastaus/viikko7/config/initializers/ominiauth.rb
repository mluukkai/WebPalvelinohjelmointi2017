Rails.application.config.middleware.use OmniAuth::Builder do
  key = ENV['GITHUB_KEY'] || '338683e14b235bfd2340'
  secret = ENV['GITHUB_SECRET'] || 'f82e806c39cf1cb78d0c163ed92036db0322d9ba'
 provider :github, key, secret 
end