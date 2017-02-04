module API
	module V1
		class Root < Grape::API
			version 'v1'
			format :json

			mount API::V1::Location
      mount API::V1::Photos
      mount API::V1::Spots
		end
	end
end
