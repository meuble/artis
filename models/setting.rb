class Setting < ActiveRecord::Base
  validates_presence_of :key, :value

   mount_uploader :image, Uploader
end
