class AddIndexesToListings < ActiveRecord::Migration
  def change
    execute "
        create index index_listing_title on listings using gin(to_tsvector('english', title));
        create index index_listing_author on listings using gin(to_tsvector('english', author));
        create index index_listing_isbn on listings using gin(to_tsvector('english', isbn));"
  end
end
