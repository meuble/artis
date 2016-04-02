class AddImageToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :image, :string
  end

  def self.down
    remove_column :settings, :image
  end
end