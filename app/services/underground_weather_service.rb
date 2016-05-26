class UndergroundWeatherService

  def initialize
    @connection = Faraday.new(url: "http://api.wunderground.com/api/#{ENV["UNDERGROUND_APP_KEY"]}/")
    @connection.headers["Authorization"] = ENV["UNDERGROUND_APP_KEY"]
  end

  def test_api
    #http://api.wunderground.com/api/f9bc7bc5873d396b/conditions/q/CA/San_Francisco.json
    json_request("conditions/q/CA/San_Francisco.json")
  end

  def json_request(path)
    response = @connection.get(path).body
    JSON.parse(response, symbolize_names: true )
  end

  def condition_by_zip(zip)
    json_result = json_request("conditions/q/%s.json" % [zip.to_s])
    city_temp(json_result)
  end

  def city_temp(json_result)
    {city: json_result[:current_observation][:display_location][:city],
      temp: json_result[:current_observation][:temperature_string]}
  end

  def conditions_by_zipcodes(*zipcodes)
    zipcodes.map do |zip|
      #need to sanitize and validate zip
      [zip.to_s, condition_by_zip(zip)]
    end.to_h
  end

  def conditions_by_geolookup
    json_geo = json_request("geolookup/q/autoip.json")
  end
end
