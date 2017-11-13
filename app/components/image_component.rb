require 'mini_magick'

class ImageComponent

  ##
  # Used to scale down an image while maintaining the original aspect-ratio
  # @param orig_width [Integer] - original image width
  # @param orig_height [Integer] - original image height
  # @param required_width [Integer] - final image width
  # @param required_height [Integer] - final image height
  # @return [final_width, final_height]
  #
  def self.scale_down_and_keep_ratio(orig_width, orig_height, required_width, required_height)

    # Check if any dimension change is needed
    if required_width >= orig_width && required_height >= orig_height
      return [orig_width, orig_height]
    end

    # Calc the ratio of the required and original dimension
    width_scale_ratio = required_width / orig_width.to_f
    height_scale_ratio = required_height / orig_height.to_f

    # Chose if we scale by height or width, always go with the smaller one
    if width_scale_ratio < height_scale_ratio
      final_width = [orig_width, required_width].min
      final_height = orig_height * (final_width / orig_width.to_f)
    else
      final_height = [orig_height, required_height].min
      final_width = orig_width * (final_height / orig_height.to_f)
    end
    return [final_width.round, final_height.round]
  end

  ##
  # Resize and pad given image stream, return
  # @param img [Stream] - image stream
  # @param required_width [Integer] - final image width
  # @param required_height [Integer] - final image height
  # @return [MiniMagick::Image]
  #
  def self.lpad(img, required_width, required_height, format=nil)
    image = MiniMagick::Image.read(img)
    final_width, final_height = scale_down_and_keep_ratio(image.width, image.height, required_width, required_height)

    image.combine_options do |f|
      # Resize
      f.resize "#{final_width}x#{final_height}"

      # Add padding
      if final_width < required_width || final_height < required_height
        f.gravity 'center'
        f.extent "#{required_width}x#{required_height}"
        f.background 'black'
      end
    end

    unless format.nil?
      image.format(format)
    end

    return image
  end
end
