class AddColumnToPost < ActiveRecord::Migration
  def change
    add_column :posts, :title, :text
  end
end
