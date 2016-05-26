class WeathersController <  ApplicationController

  def index
    @weather = UndergroundWeatherService.new
    @conditions = @weather.conditions_by_zipcodes('80204', 90242)
  end

  def new
    @zip = params[:zip]
    @weather =UndergroundWeatherService.new
    @conditions = @weather.condition_by_zip(@zip)
  end

  def create
    @weather = UndergroundWeatherService.new(params[:zip])
  end

  def show
     @city = params[:id]
    #  @weather = OpenWeather.new
     @five_day_forecast = OpenWeather.five_day_forecast(@city)
  end
end
