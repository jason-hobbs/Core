class ChangeColumnInTag < ActiveRecord::Migration
  def change
    rename_column :tags, :class, :color
  end
end
