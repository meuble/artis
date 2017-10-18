class AddPositionToMedia < ActiveRecord::Migration
  def self.up
    add_column :media, :position, :integer
  end

  def self.down
    remove_column :media, :position
  end
end
