class LastfmFetcher < Base
  def initialize(fetcher)
    @fetcher = fetcher
  end

  def fetch(artist)
    get_art_from_lastfm(artist)
  end

  private

  def last_client
    @last_client ||= Lastfm.new(Configuration.lastfm_api_key,
                                Configuration.lastfm_api_secret)
  end

  def get_art_from_lastfm(artist)
    images = last_client.artist.get_info(artist: artist, autocorrect: 1)['image']
    d "Images found: #{images.inspect}"

    Configuration.preferred_sizes.each do |size|
      image = images.find { |i| i['size'] == size && !i['content'].nil? }
      next if image.nil?

      d "Picking image: #{image.inspect}"
      download(artist, image['content'])
      break
    end
  end
end
