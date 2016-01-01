require File.expand_path("../../config/carrierwave", __FILE__)

class Uploader < CarrierWave::Uploader::Base
  storage :fog
end