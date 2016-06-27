class OpenWeatherService

  # appends &appid=ENV["OPEN_WEATHER_APP_KEY"] to the end of the every query string
  # https://github.com/lostisland/faraday/issues/483
  def initialize
    @connection = Faraday.new(url:"http://api.openweathermap.org")  do |f|
      f.use MyMiddleware, ENV["OPEN_WEATHER_APP_KEY"]
      f.adapter :net_http
    end
  end

  MyMiddleware = Struct.new(:app, :token) do
    def call(env)
      env.url.query = add_query_param(env.url.query, "appid", token)
      app.call env
    end

    def add_query_param(query, key, value)
      query = query.to_s
      query << "&" unless query.empty?
      query << "#{Faraday::Utils.escape key}=#{Faraday::Utils.escape value}"
    end
  end

  def json_request(path)
    response = @connection.get(path).body
    JSON.parse(response, symbolize_names: true )
  end
end
