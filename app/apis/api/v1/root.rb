module API
	module V1
		class Root < Grape::API
			version 'v1'
			format :json

			mount API::V1::Location
      mount API::V1::Photos
		end
	end
end
