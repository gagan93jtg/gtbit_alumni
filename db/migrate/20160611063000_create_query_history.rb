class CreateQueryHistory < ActiveRecord::Migration
  def change
    create_table :query_histories do |t|
      t.references :user
      t.references :query

      t.text    :query_string
      t.text    :tags

      t.timestamps
    end
  end
end
