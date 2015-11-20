#!/usr/bin/env ruby
# Artist Fanart Finder
#   Sept 2015
#   Alexander Standke

require 'lastfm'
require 'discogs'
require_relative 'config'

%w(configuration base fetcher lastfm discogs).each do |file|
  require_relative "lib/#{file}"
end

Configuration.configure do |conf|
  conf.lastfm_api_key     = LASTFM_API_KEY if defined?(LASTFM_API_KEY)
  conf.lastfm_api_secret  = LASTFM_API_SECRET if defined?(LASTFM_API_SECRET)
  conf.debug              = DEBUG if defined?(DEBUG)
  conf.preferred_sizes    = PREFERRED_SIZES if defined?(PREFERRED_SIZES)
  conf.trump_fanart       = TRUMP_FANART if defined?(TRUMP_FANART)
  conf.provider           = PROVIDER if defined?(PROVIDER)
  conf.discogs_user_token = DISCOGS_USER_TOKEN if defined?(DISCOGS_USER_TOKEN)
end

puts "Downloading fanart for all artists in #{ARGV.first}"
Fetcher.new(ARGV.first).fetch_all
puts 'Done.'
