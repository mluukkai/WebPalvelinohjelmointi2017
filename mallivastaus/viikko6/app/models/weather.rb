class Weather
  attr_accessor :city, :image, :temperature, :wind_speed, :wind_direction
  def initialize(hash)
    @city = hash['location']['name']
    @image = hash['current']['condition']['icon']
    @temperature = hash['current']['temp_c']
    @wind_speed = hash['current']['wind_kph']
    @wind_direction = hash['current']['wind_dir']
  end
end