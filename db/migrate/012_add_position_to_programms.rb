class AddPositionToProgramms < ActiveRecord::Migration
  def self.up
    add_column :programs, :position, :integer
  end

  def self.down
    remove_column :programs, :position
  end
end
