# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120324011210) do

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "edition"
    t.string   "isbn"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
  end

  create_table "books_courses", :id => false, :force => true do |t|
    t.integer  "book_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books_courses", ["book_id", "course_id"], :name => "index_books_courses_on_book_id_and_course_id", :unique => true
  add_index "books_courses", ["book_id"], :name => "index_books_courses_on_book_id"
  add_index "books_courses", ["course_id"], :name => "index_books_courses_on_course_id"

  create_table "courses", :force => true do |t|
    t.string   "department"
    t.string   "number"
    t.string   "name"
    t.string   "section"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "prof"
    t.integer  "school_id"
    t.string   "school_name"
  end

  create_table "listings", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "isbn"
    t.string   "edition"
    t.string   "author"
    t.integer  "price_dollars"
    t.string   "description"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id",       :default => -1
    t.string   "price_cents",   :default => "00"
  end

  create_table "networks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "networks_schools", :id => false, :force => true do |t|
    t.integer  "network_id"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "networks_schools", ["network_id"], :name => "index_networks_schools_on_network_id"
  add_index "networks_schools", ["school_id", "network_id"], :name => "index_networks_schools_on_school_id_and_network_id", :unique => true
  add_index "networks_schools", ["school_id"], :name => "index_networks_schools_on_school_id"

  create_table "requests", :force => true do |t|
    t.integer  "book_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "schools", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools_users", :id => false, :force => true do |t|
    t.integer  "school_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools_users", ["school_id", "user_id"], :name => "index_schools_users_on_school_id_and_user_id", :unique => true
  add_index "schools_users", ["school_id"], :name => "index_schools_users_on_school_id"
  add_index "schools_users", ["user_id"], :name => "index_schools_users_on_user_id"

  create_table "transactions", :force => true do |t|
    t.integer  "listing_id"
    t.string   "status",     :default => "available"
    t.string   "sell_date",  :default => "not sold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "buyer_name"
    t.integer  "buyer_id"
    t.integer  "seller_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "current_network"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
