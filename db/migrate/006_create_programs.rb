class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :section_id
      t.timestamps
    end
  end

  def self.down
    drop_table :programs
  end
end
