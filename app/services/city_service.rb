class CityService
  
  include HTTParty
  base_uri 'http://geoapi.heartrails.com/api/json'

  def self.find_current_city(latitude, longitude)
    parameters = { :query => { :method => "searchByGeoLocation", :x => longitude, :y => latitude } }
    response = self.get("/", parameters).parsed_response

    if raw_city = response['response']['location'].first
      city = {
        :name => raw_city['city'],
        :prefecture => raw_city['prefecture'],
        :postal => raw_city['postal']
      }
    else
      return nil
    end
  end
end
