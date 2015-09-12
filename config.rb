# Configuration file for Artist Image Fetcher

# Lastfm API Stuff
#   Artist image is unauthenticated, so no secret is needed
LASTFM_API_KEY = '138aa7ed99eb2137813efc55586d1d28'
LASTFM_API_SECRET = ''

# Display debugging information
DEBUG = false

# Preferred size of image download
#   Not all artists have all image sizes, so sort from most preferred to least
PREFERRED_SIZES = %w(mega extralarge large medium small)

# Trump all existing fanart
#   This will force the script to overwrite existing fanart
TRUMP_FANART = true
