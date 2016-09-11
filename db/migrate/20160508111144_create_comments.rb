class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user

      t.text    :comment_string
      t.integer :post_type # integer enumeration [1 = question, 2 = experience, 3 = job_post]
      t.integer :upvotes, default: 0
      t.integer :post_id # not added as an association because was not working well with JobPost

      t.timestamps
    end
    add_index :comments, :post_id
    add_index :comments, :user_id
    add_index :comments, :post_type
  end
end
