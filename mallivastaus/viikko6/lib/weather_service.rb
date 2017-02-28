class WeatherService
  def self.weather_for(city)
    url = "http://api.apixu.com/v1/current.json?key=#{ENV['WEATHER_KEY']}&q=#{city}"
    response = HTTParty.get(url)
    return nil if response.code != 200 or response.parsed_response['error'] and response.parsed_response['error'].any?
    Weather.new response.parsed_response
  end  
end