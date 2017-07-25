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

ActiveRecord::Schema.define(version: 20170725060640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "location_type"
    t.integer  "location_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.index ["location_type", "location_id"], name: "index_addresses_on_location_type_and_location_id", using: :btree
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.decimal  "unit_price",  precision: 12, scale: 3
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "total_price", precision: 12, scale: 3
    t.index ["item_id"], name: "index_cart_items_on_item_id", using: :btree
    t.index ["order_id"], name: "index_cart_items_on_order_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id", using: :btree
  end

  create_table "dispatchers", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dispatchers_on_user_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name"
    t.decimal  "price"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.boolean  "active"
    t.index ["store_id"], name: "index_items_on_store_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "runner_id"
    t.text     "what_they_want"
    t.string   "where_it_goes"
    t.string   "where_to_get"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "status"
    t.datetime "time_obtained"
    t.datetime "time_delivered"
    t.string   "receipt"
    t.decimal  "retail_total",   precision: 8, scale: 2
    t.index ["customer_id"], name: "index_orders_on_customer_id", using: :btree
    t.index ["runner_id"], name: "index_orders_on_runner_id", using: :btree
  end

  create_table "runners", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_runners_on_user_id", using: :btree
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "image"
    t.string   "featured"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "location"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "image"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "cart_items", "items"
  add_foreign_key "cart_items", "orders"
  add_foreign_key "customers", "users"
  add_foreign_key "items", "stores"
  add_foreign_key "orders", "customers"
end
