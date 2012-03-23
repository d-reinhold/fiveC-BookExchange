class AddFbCollegesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_colleges, :text
  end
end
