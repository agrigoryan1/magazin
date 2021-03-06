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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160427080341) do

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   default: 1
    t.decimal  "price"
    t.integer  "order_id"
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"

  create_table "orders", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "address"
    t.string   "email",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_type_id"
    t.date     "ship_date"
    t.string   "phone",           limit: 20
  end

  add_index "orders", ["payment_type_id"], name: "index_orders_on_payment_type_id"

  create_table "payment_types", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_types", ["title"], name: "index_payment_types_on_title", unique: true

  create_table "pictures", force: :cascade do |t|
    t.string   "comment"
    t.string   "name"
    t.string   "content_type"
    t.binary   "data"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "description"
    t.string   "image_url",    limit: 255
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "lock_version",             default: 0,    null: false
    t.string   "locale",       limit: 2,   default: "ru"
  end

  add_index "products", ["locale"], name: "index_products_on_locale"

  create_table "reviews", force: :cascade do |t|
    t.string   "author",          limit: 20
    t.text     "text"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "reviews", ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable_type_and_reviewable_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "password_digest",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
