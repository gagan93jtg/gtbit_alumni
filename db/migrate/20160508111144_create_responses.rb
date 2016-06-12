class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :query
      t.references :user

      t.text    :response_string
      t.integer :upvotes, default: 0

      t.timestamps
    end
    add_index :responses, :query_id
    add_index :responses, :user_id
  end
end