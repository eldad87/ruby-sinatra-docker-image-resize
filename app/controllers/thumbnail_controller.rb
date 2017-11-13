require 'sinatra'
require 'sinatra/json'
require 'open-uri'
require 'sinatra/param'
require 'json'
require './components/image_component'

class ThumbnailController < Sinatra::Base
  helpers Sinatra::Param

  before do
    content_type :json
  end

  get '/' do
    param :url,           String, blank: false, required: true, format: /(http(s?):)|([\/|.|\w|\s])*\.(?:jpg|jpeg|gif|png)/
    param :width,         Integer, min: 1, required: true
    param :height,        Integer, min: 1, required: true
    param :format,        String, blank: false, required: true, in: ['jpg','jpeg','gif','png'], default: 'jpeg'

    begin
      open(params['url']) do |img|
        # Check that we got an image
        if !img.content_type.start_with?('image') || img.status[1] != 'OK'
          _returnMsg(400, 'url', 'Image resource not found', 'Invalid URL')
        else
          newImg = ImageComponent.lpad(img, params['width'], params['height'], params['format'])
          # Notify that we're dealing with an image
          content_type newImg.mime_type
          return newImg.to_blob;
        end
      end
    rescue Exception => e
      # Log e.message
      return _returnMsg(400, 'url', 'Invalid image source', 'Error')
    end
  end

  private
  def _returnMsg(httpCode, field, fieldMsg, generalMsg)
    status httpCode
    {
        message: generalMsg,
        errors: {
            field => fieldMsg
        }
    }.to_json
  end
end
