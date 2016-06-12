class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.references :user

      t.text    :query_string
      t.text    :tags
      t.boolean :is_anonymous, default: false
      t.boolean :is_direct, default: false
      t.integer :ask_to_answer

      t.timestamps
    end
    add_index :queries, :user_id
  end
end
