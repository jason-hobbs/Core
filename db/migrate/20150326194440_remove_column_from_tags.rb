class RemoveColumnFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :textcolor, :string
  end
end
