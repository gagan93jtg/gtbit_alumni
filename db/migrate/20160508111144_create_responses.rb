class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :query
      t.references :user

      t.text    :response_string
      t.integer :upvotes, :default => 0

      t.timestamps
    end
  end
end
