require 'rails_helper'

describe UndergroundWeatherService do

  it "returns city name by zip code", :vcr do
    weather = UndergroundWeatherService.new
    city_and_temp = weather.condition_by_zip("80204")
    byebug
    expect(city_and_temp[:city]).to eq("Denver")
  end
end
