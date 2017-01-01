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

ActiveRecord::Schema.define(version: 20170101070801) do

  create_table "line_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "purchase_type"
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity",                              default: 0
    t.decimal  "price",         precision: 8, scale: 2
    t.index ["order_id"], name: "index_line_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_line_items_on_product_id", using: :btree
    t.index ["purchase_type"], name: "index_line_items_on_purchase_type", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "user_id"
    t.string   "ip_address"
    t.string   "status"
    t.string   "phone"
    t.string   "address"
    t.string   "first_name"
    t.string   "last_name"
    t.decimal  "shipping_price",   precision: 8, scale: 2
    t.decimal  "tax_price",        precision: 8, scale: 2
    t.decimal  "discounted_price", precision: 8, scale: 2
    t.decimal  "subtotal_price",   precision: 8, scale: 2
    t.decimal  "total_price",      precision: 8, scale: 2
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "order_id"
    t.decimal  "amount",      precision: 8, scale: 2
    t.string   "external_id"
    t.string   "status"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["external_id"], name: "index_payments_on_external_id", using: :btree
    t.index ["order_id"], name: "index_payments_on_order_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.string   "asin"
    t.string   "name"
    t.decimal  "price",                            precision: 8, scale: 2
    t.text     "description",        limit: 65535
    t.string   "brand"
    t.string   "category_name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "stock",                                                    default: 0
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "phone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
end
