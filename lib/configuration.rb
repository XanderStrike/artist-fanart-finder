class Configuration
  attr_accessor :lastfm_api_key, :lastfm_api_secret, :debug,
                :preferred_sizes, :trump_fanart, :provider

  @config = nil

  def initialize
    @lastfm_api_key = '138aa7ed99eb2137813efc55586d1d28'
    @debug = false
    @preferred_sizes = %w(mega extralarge large medium small)
    @trump_fanart = false
    @provider = 'Lastfm'
  end

  def self.configure
    @config ||= new
    yield(@config)
  end

  def self.method_missing(method)
    @config.send(method)
  end
end
