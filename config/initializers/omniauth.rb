# in config/initializers/omniauth.rb

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_APP_SECRET"],
           :scope => 'email,user_birthday,publish_actions,user_photos,user_posts,public_profile,user_about_me', :display => 'popup'
end
