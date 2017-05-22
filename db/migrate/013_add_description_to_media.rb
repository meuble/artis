class AddDescriptionToMedia < ActiveRecord::Migration
  def self.up
    add_column :media, :description, :text
  end

  def self.down
    remove_column :media, :description
  end
end
