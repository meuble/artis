class Concert < ActiveRecord::Base
  mount_uploader :image, Uploader
  validates_presence_of :title, :date

  def musicians=(params)
    self.musician_ids = ""

    return musician_ids if params.nil? || !params.is_a?(Hash)

    self.musician_ids = params.keys.inject([]) do |acc, musician_id|
      if Musician.where(:id => musician_id).exists?
        acc << musician_id
      end
      acc
    end.join(",")
  end

  def musicians
    Musician.where(:id => self.musician_ids.try(:split, ","))
  end
end
