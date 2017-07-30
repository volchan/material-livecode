class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :author
      t.integer :descendent
      t.integer :score
      t.integer :posted_at
      t.string :title
      t.string :type
      t.string :url

      t.timestamps
    end
  end
end
