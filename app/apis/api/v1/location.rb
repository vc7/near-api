module API
	module V1
		class Location < Grape::API
			resource :location do
				desc 'Return Location Info.'
				get do
					# params[:ll]
					# 從 params 取得經緯度之後，個別產出 temperature 和附近車站
					{
						:name => "豊島区",
						:temperature => {
							:current => 10,
							:high => 13,
							:low => 1,
						},
						:nearby_stations => [
							"要町", "千川", "池袋"
						]
					}
				end
			end
		end
	end
end
