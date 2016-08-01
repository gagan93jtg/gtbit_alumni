class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string  :first_name
      t.string  :last_name
      t.string  :username
      t.string  :gender
      t.text  :bio

      t.string  :batch
      t.string  :company
      t.string  :job_type
      t.string  :designation
      t.integer :experience_in_years, default: 0

      t.string  :phone
      t.string  :fb_link
      t.string  :twitter_link
      t.string  :linked_in_link

      t.boolean :is_admin, default: false

      t.timestamps
    end
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :phone
  end
end
