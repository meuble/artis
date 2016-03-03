class AddFieldToConcert < ActiveRecord::Migration
  def self.up
    add_column :concerts, :subtitle, :string
    add_column :concerts, :place, :string
  end

  def self.down
    remove_column :concerts, :subtitle
    remove_column :concerts, :place
  end
end