# Configuration file for Artist Fanart Finder
#   Defaults are listed here. Change as you see fit.

# Lastfm API Stuff
#   Artist image is unauthenticated, so no secret is needed
LASTFM_API_KEY = '138aa7ed99eb2137813efc55586d1d28'
LASTFM_API_SECRET = ''

# Discogs API Stuff
DISCOGS_USER_TOKEN = ''

# Display debugging information
DEBUG = false

# Preferred size of image download
#   Not all artists have all image sizes, so sort from most preferred to least
#   For google, use one of :huge, :xxlarge, :xlarge, :large, :medium, :small, :icon
PREFERRED_SIZES = %w(mega extralarge large medium small)

# Trump all existing fanart
#   This will force the script to overwrite existing fanart
TRUMP_FANART = true

# Image Provider
#   This setting selects which image provider we check
#   Lastfm - Probably the most accurate and complete, small images, recommended
#   Discogs - Fairly complete, small images, often portrait (bad for Kodi)
#   Google - Fast but many inaccurate images, very large sizes available. Not
#            recommended unless you want to fix all the wrong images.
PROVIDER = 'Lastfm'
