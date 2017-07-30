class ChangeColumnNameFromPosts < ActiveRecord::Migration[5.0]
  def up
    rename_column :posts, :type, :category
    rename_column :posts, :descendent, :descendants
  end

  def down
    rename_column :posts, :category, :type
    rename_column :posts, :descendants, :descendent
  end
end
