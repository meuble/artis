class CreateMusicians < ActiveRecord::Migration
  def self.up
    create_table :musicians do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.boolean :is_core_member
      t.timestamps
    end
  end

  def self.down
    drop_table :musicians
  end
end
