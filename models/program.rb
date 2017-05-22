class Program < ActiveRecord::Base
   mount_uploader :image, ResizedUploader
   mount_uploader :attachment, PDFUploader
end
