class CreateMedia < ActiveRecord::Migration
  def self.up
    create_table :media do |t|
      t.string :title
      t.string :kind
      t.string :media
      t.text :embed
      t.timestamps
    end
  end

  def self.down
    drop_table :media
  end
end
