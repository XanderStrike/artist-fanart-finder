#!/usr/bin/env ruby
# Get artist fanart

DEBUG = true

class Base
  private

  def d(string)
    puts "D - #{string}" if DEBUG
  end
end

class Fetcher < Base
  def initialize(path)
    @path = path
    @artists = Dir.new(path).to_a.reject! { |dir| %w(. ..).include?(dir) }
    d @artists.inspect
  end

  def fetch_all
    @artists.each do |a|
      next if art_exist?(a)
      puts "Fetching art for #{a}"
    end
  end

  private

  def art_exist?(artist)
    %w(png jpg).each do |type|
      return true if File.exist?("#{@path}/#{artist}/fanart.#{type}")
    end
    false
  end
end

class ArtFetcher < Base

end

Fetcher.new(ARGV.first).fetch_all
