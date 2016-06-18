class CreatePostHistory < ActiveRecord::Migration
  def change
    create_table :post_histories do |t|
      t.references :user
      t.references :post

      t.text    :query_string
      t.text    :tags

      t.timestamps
    end
    add_index :post_histories, :user_id
    add_index :post_histories, :post_id
  end
end
