class AddAnotherReferenceToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :tag, index: true
  end
end
