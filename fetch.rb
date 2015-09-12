#!/usr/bin/env ruby
# Artist Fanart Finder
#   Sept 2015
#   Alexander Standke

require 'lastfm'
require_relative 'config.rb'

class Base
  private

  def d(string)
    puts "D - #{string}" if DEBUG
  end

  def download(artist, url)
    suffix = url.split('.').last
    `wget #{url} -o /dev/null -bO "#{@fetcher.path}/#{artist}/fanart.#{suffix}"`
    puts "Downloaded image for #{artist}"
  end
end

class Fetcher < Base
  attr_reader :path, :artists

  def initialize(path)
    @path = path
    @artists = Dir.new(path).to_a.reject! { |dir| dir.start_with?('.') }
    d @artists.inspect
  end

  def fetch_all
    fetcher = "#{PROVIDER}Fetcher".constantize.new(self)

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
      return true if !TRUMP_FANART && File.exist?("#{@path}/#{artist}/fanart.#{type}")
    end
    false
  end
end

class LastfmFetcher < Base
  def initialize(fetcher)
    @fetcher = fetcher
  end

  def fetch(artist)
    get_art_from_lastfm(artist)
  end

  private

  def last_client
    @last_client ||= Lastfm.new(LASTFM_API_KEY, LASTFM_API_SECRET)
  end

  def get_art_from_lastfm(artist)
    images = last_client.artist.get_info(artist: artist, autocorrect: 1)['image']
    d "Images found: #{images.inspect}"
    PREFERRED_SIZES.each do |size|
      image = images.find { |i| i['size'] == size && !i['content'].nil? }
      next if image.nil?

      d "Picking image: #{image.inspect}"
      download(artist, image['content'])
      break
    end
  end
end

puts "Downloading fanart for all artists in #{ARGV.first}"
Fetcher.new(ARGV.first).fetch_all
puts 'Done.'
