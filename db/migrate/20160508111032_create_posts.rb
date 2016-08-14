class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user

      t.text    :query_string
      t.string  :tags
      t.integer :post_type      # post_type = 1 for Question and 2 for Experience
      t.boolean :is_anonymous, default: false

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :post_type
  end
end
