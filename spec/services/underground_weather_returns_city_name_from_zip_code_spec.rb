require 'rails_helper'

describe UndergroundWeatherService do

  it "returns city name from zip code", :vcr do
    weather = UndergroundWeatherService.new
    city_and_temp = weather.condition_by_zip("80204")

    expect(city_and_temp[:city]).to eq("Denver")
  end
end
