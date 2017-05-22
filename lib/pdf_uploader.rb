require File.expand_path("../../config/carrierwave", __FILE__)

class PDFUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  def extension_white_list
    %w(pdf)
  end
end
