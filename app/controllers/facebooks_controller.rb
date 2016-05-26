class FacebooksController < ApplicationController

  def index
    fb = FacebookService.new(session['access_token'])
    # @result = @fb.json_post_request("/me/feed?message=hello2")
    @profile_url = fb.get_profile_picture
  end

  def update_timeline
    @city = params[:city]
    message = weather_url(@city)
    fb = FacebookService.new(session['access_token'])
    fb.json_post_request("/me/feed?message=%s" % [message])
    redirect_to weather_url(@city)
  end

end
