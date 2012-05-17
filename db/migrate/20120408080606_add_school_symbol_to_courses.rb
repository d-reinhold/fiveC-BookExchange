class AddSchoolSymbolToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :school_symbol, :string
  end
end
