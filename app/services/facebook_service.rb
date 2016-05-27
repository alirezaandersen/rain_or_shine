class FacebookService

  #https://graph.facebook.com/me?access_token=EAAJGNRf43X4BAOrAIkfp2WhtPBLoKQddV7teC5WiuCXoOvpP2XlxuZBMV7dX7FIODwSbwDyO7R3wy808X0RnlHZB0qhFZC1HZCsGLCkf3nPe0eDJqV3NftKjsEAVgJokFSHMhtmmteqbhc138gckNcu3BaVZCWNaZCaKL1ZBgZBIWgZDZD
  # attr_reader: access_token #replace params arguments

  def initialize(access_token)
      @access_token = access_token
      long_lived_access_token = implemented_long_lived_access_token
      request_options = {params: {"access_token": long_lived_access_token} }
      @connection = Faraday.new("https://graph.facebook.com/", request_options)
  end

  # def initialize(access_token)
  #   set_enduring_access_token(access_token)
  #   @connection = Faraday.new("https://graph.facebook.com/", @request_options)
  # end

  def set_enduring_access_token(access_token)
    long_lived_access_token = implemented_long_lived_access_token

        response = request_long_lived_access_token
    enduring_access_token = URI.decode_www_form(response.body).to_h.fetch('access_token',nil)

    request_options = {params: {"access_token": enduring_access_token} }

  end


  def implemented_long_lived_access_token
    response = request_long_lived_access_token
    URI.decode_www_form(response.body).to_h.fetch('access_token',nil)
  end

  def request_long_lived_access_token
    request_options = {params: {"access_token": @access_token} }
    connection = Faraday.new("https://graph.facebook.com/", request_options)

    path = '/oauth/access_token?'
    params = URI.encode_www_form(client_id: ENV['FACEBOOK_APP_ID'],
                                 client_secret: ENV['FACEBOOK_APP_SECRET'],
                                 grant_type: 'fb_exchange_token',
                                 fb_exchange_token: @access_token )
    connection.get([path,params].join)
  end

  def json_get_request(path)
      response = @connection.get(path).body
      JSON.parse(response, symbolize_names: true )
  end

  def parse_profile_picture
    get_profile_picture.headers['location']
  end

  def get_profile_picture
    response = @connection.get '/me/picture'
  end

  def json_post_request(path)
    response = @connection.post(path).body
    JSON.parse(response, symbolize_names: true )
  end


end
