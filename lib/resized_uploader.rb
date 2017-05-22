require File.expand_path("../../config/carrierwave", __FILE__)

class ResizedUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog
  version :normal do
    process :custom_large_resize
  end
  version :thumb do
    process :custom_thumb_resize
  end
  
  def custom_thumb_resize
    custom_resize(200, 150)
  end

  def custom_large_resize
    custom_resize(1000, 750)
  end

  def custom_resize(w, h)
    image = ::MiniMagick::Image::read(File.binread(@file.file))
    resize_and_pad(w, h, "FFFFF", gravity = 'Center')
  end

end
