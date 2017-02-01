module API
	module V1
		class Location < Grape::API
			resource :location do
				desc 'Return Location Info.'
				get do
					# params[:ll]
					# 從 params 取得經緯度之後，個別產出 temperature 和附近車站

					longitude = 139.6983441
					latitude = 35.736253

					nearby_stations = StationService.find_nearing_stations latitude, longitude

					{
						:name => "豊島区",
						:temperature => {
							:current => 10,
							:high => 13,
							:low => 1,
						},
						:nearby_stations => nearby_stations
					}
				end
			end
		end
	end
end
