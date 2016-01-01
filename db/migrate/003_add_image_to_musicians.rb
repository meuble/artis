class AddImageToMusicians < ActiveRecord::Migration
  def self.up
    add_column :musicians, :image, :string
  end

  def self.down
    remove_column :musicians, :image
  end
end