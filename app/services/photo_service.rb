class PhotoService
  
  include HTTParty
  base_uri 'https://api.flickr.com/services/rest/'

  def self.find_photos(latitude, longitude)

    api_key = ENV['flickr_api_key']

    if !api_key
      return []
    end

    parameters = { :query => { 
      :method => "flickr.photos.search", 
      :api_key => api_key,
      :lat => latitude,
      :lon => longitude, 
      :radius => 1, 
      :radius_units => 'km', 
      :format => 'json', 
      :per_page => 10,
      :sort => 'interestingness-desc',
      :content_type => 1,
      :nojsoncallback => 1 # prevent wrapping of `jsonFlickrApi()` around responsed json data
    }}

    response = self.get("/", parameters).parsed_response

    if response['stat'] == 'ok'
      photos = []
      raw_photos = response['photos']['photo']

      raw_photos.each do |raw_photo|
        photo = {
          :id => raw_photo['id'],
          :owner => raw_photo['owner'],
          :title => raw_photo['title'],
          :medias => self.generate_image_urls(raw_photo)
        }

        photos.push(photo)
      end

      return photos
    else
      []
    end
  end

  def self.generate_image_urls(raw_photo)
    {
      :medium => self.generate_single_image_url(raw_photo, ''),
      :large => self.generate_single_image_url(raw_photo, 'b')
    }
  end

  def self.generate_single_image_url(raw_photo, size)

    # https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
    
    id = raw_photo['id']
    farm_id = raw_photo['farm']
    server_id = raw_photo['server']
    secret = raw_photo['secret']

    if size.length > 0
      url = "https://farm#{farm_id}.staticflickr.com/#{server_id}/#{id}_#{secret}_#{size}.jpg"
    else
      url = "https://farm#{farm_id}.staticflickr.com/#{server_id}/#{id}_#{secret}.jpg"
    end
  end
end
