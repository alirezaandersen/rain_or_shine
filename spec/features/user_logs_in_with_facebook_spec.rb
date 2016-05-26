require "rails_helper"


RSpec.feature "User logs in with Facebook" do

  xscenario "User logs in with Facebook" do
    set_omniauth()

    visit root_path
    click_link"Sign in with FaceBook"
    save_and_open_page
  end
end
