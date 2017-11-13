require 'sinatra/base'

require_relative 'controllers/thumbnail_controller'

map('/thumbnail') { run ThumbnailController }