module API
  module V1
    class Photos < Grape::API
      resource :photos do
        desc 'Return Location Info.'
        get do
          # params[:ll]
          # 從 params 取得經緯度之後，個別產出 temperature 和附近車站

          longitude = 139.6983441
          latitude = 35.736253

          nearby_stations = StationService.find_nearing_stations latitude, longitude
          city = CityService.find_current_city(latitude, longitude)
          temperature = WeatherService.find_weather_information(city[:prefecture] + city[:name])

          {
            :city => city,
            :temperature => temperature,
            :nearby_stations => nearby_stations
          }
        end
      end
    end
  end
end
