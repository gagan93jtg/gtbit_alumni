class AddGithubLinkToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :github_link, default: ''
    end
  end
end

