class AddIndexesToListings < ActiveRecord::Migration
  def change
    execute "
        create index on listings using gin(to_tsvector('english', title));
        create index on listings using gin(to_tsvector('english', author));
        create index on listings using gin(to_tsvector('english', isbn));"
  end
end
