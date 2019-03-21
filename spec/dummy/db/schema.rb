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

ActiveRecord::Schema.define(version: 2018_08_27_000638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.decimal "width", precision: 4, scale: 1, null: false
    t.decimal "height", precision: 4, scale: 1, null: false
    t.decimal "depth", precision: 4, scale: 1, null: false
    t.integer "publication_year", null: false
    t.string "materials", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_addresses", force: :cascade do |t|
    t.string "address", null: false
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "country", null: false
    t.string "city", null: false
    t.string "zipcode", null: false
    t.string "phone", null: false
    t.integer "address_type"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_sh_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "shopping_cart_books", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.decimal "width", precision: 4, scale: 1, null: false
    t.decimal "height", precision: 4, scale: 1, null: false
    t.decimal "depth", precision: 4, scale: 1, null: false
    t.integer "publication_year", null: false
    t.string "materials", null: false
    t.bigint "category_id"
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_coupons", force: :cascade do |t|
    t.bigint "order_id"
    t.string "code", null: false
    t.decimal "discount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_credit_cards", force: :cascade do |t|
    t.string "number"
    t.string "cvv"
    t.bigint "order_id"
    t.string "card_name", null: false
    t.string "expiration_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_deliveries", force: :cascade do |t|
    t.string "title", null: false
    t.string "days", null: false
    t.decimal "price", precision: 5, scale: 2, null: false
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.decimal "summary_price", precision: 10, scale: 2
    t.bigint "user_id"
    t.boolean "use_billing", default: false, null: false
    t.datetime "completed_date"
    t.boolean "email_confirmed", default: false
    t.string "confirmation_token"
    t.string "state", default: "in_progress"
    t.string "tracking_number"
    t.decimal "total_price", precision: 10, scale: 2, default: "0.0"
    t.bigint "delivery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_positions", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "order_id"
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
