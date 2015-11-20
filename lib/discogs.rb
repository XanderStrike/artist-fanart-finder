class DiscogsFetcher < Base
  def initialize(fetcher)
    @fetcher = fetcher
  end

  def fetch(artist)
    get_art_from_discogs(artist)
  end

  private

  def discogs_client
    @client ||= Discogs::Wrapper.new('CD Art Fetch', user_token: Configuration.discogs_user_token)
  end

  def get_art_from_discogs(artist)
    id = discogs_client.search(artist: artist).results.first.id
    url = discogs_client.get_artist(id).images.first.uri

    d "Picking image #{url}"
    download(artist, url)
  rescue
    puts 'Nothing found'
  end
end
