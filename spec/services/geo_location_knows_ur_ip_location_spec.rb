require 'rails_helper'

describe UndergroundWeather do
  it "geo location knows your location" do
    VCR.use_cassette("applicationcontroller#geo_by_location") do
      location = UndergroundWeather.geo_by_location

      expect(location[:city]).to eq("Denver")
    end
  end
end
