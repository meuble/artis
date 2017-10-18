require File.expand_path("../../config/carrierwave", __FILE__)

class ConcertUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog
  version :normal do
    process resize_to_fit: [1000, 2000]
  end
  version :thumb do
    process resize_to_fit: [200, 500]
  end
end