class ChangeNameFromTextToStringInEvents < ActiveRecord::Migration
  def self.up
    change_column :events, :name, :string
  end

  def self.down
    change_column :events, :name, :text
  end
end
