module API
  module V1
    class Spots < Grape::API
      resource :spots do
        desc 'Return nearby trend spots currently.'
        get do

          longitude = params['longitude']
          latitude = params['latitude']

          if !latitude && !longitude
            return []
          end

          spots = SpotService.find_trend_spots(latitude, longitude)
        end
      end
    end
  end
end
