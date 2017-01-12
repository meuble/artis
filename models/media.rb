class Media < ActiveRecord::Base
  KINDS = ["Photos", "Videos", "Presse", "Audio"]
  
  mount_uploader :media, ResizedUploader
  validates_presence_of :title
  validates_inclusion_of :kind, in: KINDS
end
