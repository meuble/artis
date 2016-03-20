class Musician < ActiveRecord::Base
   mount_uploader :image, Uploader
   validates_presence_of     :name, :description, :position
   validates :is_core_member, :inclusion => { :in => [true, false] }
end
