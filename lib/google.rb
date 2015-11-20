class GoogleFetcher < Base
  def initialize(fetcher)
    @fetcher = fetcher
  end

  def fetch(artist)
    get_art_from_google(artist)
  end

  private

  def get_art_from_google(artist)
    Google::Search::Image.new(query: "#{artist} music", image_size: Configuration.preferred_sizes, image_type: :photo).each do |image|
      next unless (image.width * 1.0 / image.height) > 1.25
      download(artist, image.uri)
      break
    end
  end
end
