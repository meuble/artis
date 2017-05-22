class AddAttachmentToPrograms < ActiveRecord::Migration
  def self.up
    add_column :programs, :attachment, :string
  end

  def self.down
    remove_column :programs, :attachment
  end
end