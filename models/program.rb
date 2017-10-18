class Program < ActiveRecord::Base
   mount_uploader :image, ConcertUploader
   mount_uploader :attachment, PDFUploader
end
