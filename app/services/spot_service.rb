class SpotService
  
  include HTTParty
  base_uri 'https://api.foursquare.com/v2/venues/trending'

  def self.find_trend_spots(latitude, longitude)

    client_id = ENV['foursquare_client_id']
    client_secret = ENV['foursquare_client_secret']

    if !client_id && !client_id
      return []
    end

    parameters = { :query => 
        { 
          :client_id => client_id,
          :client_secret => client_secret,
          :v => '20170202',
          :limit => 10,
          :ll => "#{latitude},#{longitude}", 
          :locale => 'ja'
        } 
      }
    response = self.get("/", parameters).parsed_response
  end
end
