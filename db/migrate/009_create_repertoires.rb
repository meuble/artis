class CreateRepertoires < ActiveRecord::Migration
  def self.up
    create_table :repertoires do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :repertoires
  end
end
