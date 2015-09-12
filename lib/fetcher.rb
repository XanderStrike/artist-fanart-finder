class Fetcher < Base
  attr_reader :path, :artists

  def initialize(path)
    @path = path
    @artists = Dir.new(path).to_a.reject! { |dir| dir.start_with?('.') }
    d @artists.inspect
  end

  def fetch_all
    fetcher = "#{Configuration.provider}Fetcher".constantize.new(self)

    @artists.each do |artist|
      next if should_download?(artist)
      get_for_artist(fetcher, artist)
    end
  end

  private

  def get_for_artist(fetcher, artist)
    puts "Fetching art for #{artist}"
    fetcher.fetch(artist)
  rescue Lastfm::ApiError => error
    d error.inspect
    puts "Could not find #{artist}... skipping"
  end

  def should_download?(artist)
    %w(png jpg).each do |type|
      return true if !Configuration.trump_fanart &&
                     File.exist?("#{@path}/#{artist}/fanart.#{type}")
    end
    false
  end
end
