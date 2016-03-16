class Program < ActiveRecord::Base
   mount_uploader :image, ResizedUploader
end
