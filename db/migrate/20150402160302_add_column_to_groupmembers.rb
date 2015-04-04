class AddColumnToGroupmembers < ActiveRecord::Migration
  def change
    add_column(:groupmembers, :last_visit, :datetime)
  end
end
