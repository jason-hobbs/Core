class CreateLinkModelGroupmembers < ActiveRecord::Migration
  def change
    create_table :groupmembers do |t|
      t.references :user, index: true
      t.references :group, index: true
    end
  end
end
