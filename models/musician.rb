class Musician < ActiveRecord::Base
   mount_uploader :image, Uploader
   validates_presence_of     :name, :description, :position, :is_core_member

end
