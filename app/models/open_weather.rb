class OpenWeather

  def self.service
    OpenWeatherService.new
  end

  def self.future_forecast(city)
    #@connection.get "/data/2.5/forecast?q=#{city},us&unit=imperial"
    path = '/data/2.5/forecast?'
    params = URI.encode_www_form(q:"#{city},us",
                                 units: "imperial"
    )
    a = OpenWeather.service.json_request([path,params].join)
  end

  def self.five_day_forecast(city)
    future_forecast(city)[:list].map.with_index{|item,index| [item[:dt_txt].split[0],item[:weather].last[:description]]}
  end


end
