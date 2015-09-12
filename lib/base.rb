class Base
  private

  def d(string)
    puts "D - #{string}" if Configuration.debug
  end

  def download(artist, url)
    suffix = url.split('.').last
    `wget #{url} -o /dev/null -bO "#{@fetcher.path}/#{artist}/fanart.#{suffix}"`
    puts "Downloaded image for #{artist}"
  end
end
