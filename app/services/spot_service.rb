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
          :v => Date.today.strftime('%Y%m%d'),
          :limit => 10,
          :ll => "#{latitude},#{longitude}", 
          :locale => 'ja'
        } 
      }
    response = self.get("/", parameters).parsed_response

    if response['meta']['code'] != 200 
      return []
    end

    spots = []
    raw_spots = response['response']['venues']

    raw_spots.each do |raw_spot|
      spot = {
        :id => raw_spot['id'],
        :name => raw_spot['name'],
        :access => {
          :latitude => raw_spot['location']['lat'],
          :longitude => raw_spot['location']['lng'],
          :distance => raw_spot['location']['distance'],
          :address => raw_spot['location']['formattedAddress'].reverse.join(" ")
        },
        :category_icon => "#{raw_spot['categories'][0]['icon']['prefix']}88#{raw_spot['categories'][0]['icon']['suffix']}",
        :here_count => raw_spot['hereNow']['count']
      }

      spots.push(spot)
    end

    return spots
  end
end
