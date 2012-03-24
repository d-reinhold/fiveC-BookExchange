class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :uid
      t.string :name

      t.timestamps
    end
  end
end
