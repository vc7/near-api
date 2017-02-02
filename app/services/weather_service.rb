class WeatherService
  
  include HTTParty
  base_uri 'https://query.yahooapis.com/v1/public/yql'

  def self.find_weather_information(name)
    parameters = { :query => { :q => "select item from weather.forecast where woeid in (select woeid from geo.places(1) where text='東京都豊島区') and u='c'", :format => "json"} }
    response = self.get("/", parameters).parsed_response

    temperature_current = response['query']['results']['channel']['item']['condition']['temp']
    temperature_high = response['query']['results']['channel']['item']['forecast'].first['high']
    temperature_low = response['query']['results']['channel']['item']['forecast'].first['low']

    result = {
      :current => temperature_current,
      :high => temperature_high,
      :low => temperature_low
    }
  end
end
