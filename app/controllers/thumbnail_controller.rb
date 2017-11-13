require 'sinatra'
require 'sinatra/json'
require 'open-uri'
require 'sinatra/param'
require 'json'

class ThumbnailController < Sinatra::Base
  helpers Sinatra::Param

  before do
    content_type :json
  end

  get '/' do
    status 200
    {
        message: 'hello'
    }.to_json
  end
end