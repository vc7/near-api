module API
  module V1
    class Photos < Grape::API
      resource :photos do
        desc 'Return nearby photos.'
        get do

          longitude = params['longitude']
          latitude = params['latitude']

          if !latitude && !longitude
            return []
          end

          photos = PhotoService.find_photos(latitude, longitude)
        end
      end
    end
  end
end
