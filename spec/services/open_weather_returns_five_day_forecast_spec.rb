require 'rails_helper'

describe OpenWeather do

  it "returns a five day forecast" do
    VCR.use_cassette("openweather#five_day_forecast") do
      five_day = OpenWeather.five_day_forecast("Denver")

      expect(five_day.count).to equal(40)
    end
  end
end
