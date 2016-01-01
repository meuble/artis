class CreateConcerts < ActiveRecord::Migration
  def self.up
    create_table :concerts do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.string :image
      t.string :musician_ids
      t.timestamps
    end
  end

  def self.down
    drop_table :concerts
  end
end
