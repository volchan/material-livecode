class AddFieldToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :hn_id, :integer
  end
end
