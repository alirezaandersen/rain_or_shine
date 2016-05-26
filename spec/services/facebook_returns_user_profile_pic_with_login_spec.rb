require 'rails_helper'

describe FacebookService do
  it "once logged in, a users_profile_picture is shown", :vcr do
    facebook = FacebookService.new(ENV["FACEBOOK_ACCESS_TOKEN_TEST"])
    picture = facebook.parse_profile_picture

    assert picture.include?(".jpg?")
  end
end
