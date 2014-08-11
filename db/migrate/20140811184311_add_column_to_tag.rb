class AddColumnToTag < ActiveRecord::Migration
  def change
    add_column :tags, :textcolor, :string
  end
end
