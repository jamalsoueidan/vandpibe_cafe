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

ActiveRecord::Schema.define(:version => 20130427100431) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "brands", :force => true do |t|
    t.string "name"
    t.string "country"
    t.text   "description"
  end

  create_table "cities", :force => true do |t|
    t.string  "name"
    t.string  "latitude"
    t.string  "longitude"
    t.boolean "visible",         :default => true
    t.string  "color"
    t.integer "locations_count", :default => 0
    t.integer "country_id"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.boolean  "visible",          :default => true
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.boolean  "anonymous",        :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "countries", :force => true do |t|
    t.string "name"
    t.string "color"
  end

  create_table "locations", :force => true do |t|
    t.string  "name"
    t.string  "address"
    t.string  "post"
    t.string  "latitude"
    t.string  "longitude"
    t.integer "city_id"
    t.boolean "visible",          :default => true
    t.float   "furniture_rating", :default => 0.0
    t.float   "waterpipe_rating", :default => 0.0
    t.float   "service_rating",   :default => 0.0
    t.float   "mood_rating",      :default => 0.0
    t.boolean "television",       :default => false
    t.boolean "music",            :default => false
    t.boolean "football",         :default => false
    t.text    "openings_time"
    t.text    "description"
  end

  create_table "locations_menus", :id => false, :force => true do |t|
    t.integer "menu_id"
    t.integer "location_id"
  end

  create_table "locations_tobaccos", :id => false, :force => true do |t|
    t.integer  "tobacco_id"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "menus", :force => true do |t|
    t.string "name"
    t.string "link"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "category_id"
    t.boolean  "visible",     :default => true
    t.boolean  "anonymous",   :default => false
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.string   "rating_key"
    t.float    "rating_value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "ratings", ["location_id"], :name => "index_ratings_on_location_id"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "references", :force => true do |t|
    t.string  "name"
    t.string  "link"
    t.integer "location_id"
  end

  create_table "tobaccos", :force => true do |t|
    t.string  "name"
    t.string  "rating"
    t.integer "brand_id"
  end

  create_table "uploads", :force => true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "title"
    t.integer  "uploadable_id"
    t.string   "uploadable_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "nickname"
    t.string   "fullname"
    t.string   "email"
    t.string   "ip_address"
    t.string   "provider"
    t.string   "session"
    t.string   "uid"
    t.string   "location"
    t.string   "avatar_url"
    t.string   "gender"
    t.integer  "status",       :default => 0
    t.boolean  "vip",          :default => false
    t.boolean  "closed",       :default => false
    t.datetime "created_date"
    t.datetime "logged_date"
    t.integer  "sign_count",   :default => 1
  end

  add_index "users", ["session"], :name => "index_users_on_session"

end
