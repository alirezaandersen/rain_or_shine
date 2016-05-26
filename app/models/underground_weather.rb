class UndergroundWeather

  def self.service
    UndergroundWeatherService.new
  end

  def self.geo_by_location
    geo_zip = UndergroundWeather.service.conditions_by_geolookup[:location][:zip]
    UndergroundWeather.service.condition_by_zip(geo_zip)
  end

end
