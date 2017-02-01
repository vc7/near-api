class StationService
	
	include HTTParty
	base_uri 'http://express.heartrails.com/api/json'

	def self.find_nearing_stations(latitude, longitude)
		parameters = { :query => { :method => "getStations", :x => longitude, :y => latitude } }
		response = self.get("/", parameters).parsed_response

    stations = []

    if raw_stations = response['response']['station']
      raw_stations.each do |raw_station|
        name = raw_station['name']
        if !stations.include? name 
          stations.push name
        end
      end
    end

    stations
  end
end
