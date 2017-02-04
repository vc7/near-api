class WeatherService
  
  include HTTParty
  base_uri 'https://query.yahooapis.com/v1/public/yql'

  def self.find_weather_information(name)
    parameters = { :query => { :q => "select item from weather.forecast where woeid in (select woeid from geo.places(1) where text='#{name}') and u='c'", :format => "json"} }
    response = self.get("/", parameters).parsed_response

    begin
      item = response['query']['results']['channel']['item']

      temperature_current = item['condition']['temp']
      temperature_high = item['forecast'][0]['high']
      temperature_low = item['forecast'][0]['low']

      {
        :current => temperature_current,
        :high => temperature_high,
        :low => temperature_low
      }
    rescue => e
      {}
    end
    
  end
end
