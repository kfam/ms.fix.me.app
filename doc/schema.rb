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

ActiveRecord::Schema.define(:version => 20121125175813) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "url_segment"
    t.integer  "published_status"
    t.integer  "parent_category_id"
    t.text     "description"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "categories_products", :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
    t.integer "position"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "url_segment"
    t.integer  "published_status"
    t.string   "subcode"
    t.text     "description"
    t.string   "strapline"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "variants", :force => true do |t|
    t.string   "sku"
    t.integer  "product_id"
    t.integer  "price"
    t.integer  "weight_in_grams"
    t.string   "description"
    t.string   "bay"
    t.integer  "stock_level_total"
    t.integer  "stock_level_reserved"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

end
