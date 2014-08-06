class AddColumnToTags < ActiveRecord::Migration
  def change
    add_column :tags, :class, :string
  end
end
