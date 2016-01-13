class Program < ActiveRecord::Base
   mount_uploader :image, Uploader
end
