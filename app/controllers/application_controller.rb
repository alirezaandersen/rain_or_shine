class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :geo_location, :profile_picture

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def geo_location
    UndergroundWeather.geo_by_location
  end

  def profile_picture
    user_profile = FacebookService.new(session['access_token'])
    user_profile.parse_profile_picture
  end

end
