# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_09_085139) do

  create_table "active_storage_attachments", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "carts", charset: "utf8mb4", force: :cascade do |t|
    t.integer "quantity", limit: 2
    t.datetime "date_add"
    t.bigint "user_id", null: false
    t.bigint "product_detail_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_detail_id"], name: "index_carts_on_product_detail_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", charset: "utf8mb4", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "jwt_auths", charset: "utf8mb4", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_jwt_auths_on_user_id"
  end

  create_table "likes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_likes_on_product_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", charset: "utf8mb4", force: :cascade do |t|
    t.string "content"
    t.integer "user_sender_id"
    t.integer "user_receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_receiver_id"], name: "index_messages_on_user_receiver_id"
    t.index ["user_sender_id"], name: "index_messages_on_user_sender_id"
  end

  create_table "order_details", charset: "utf8mb4", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "cost_product", precision: 10
    t.bigint "order_id", null: false
    t.bigint "product_detail_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_detail_id"], name: "index_order_details_on_product_detail_id"
  end

  create_table "orders", charset: "utf8mb4", force: :cascade do |t|
    t.string "delivery_address"
    t.string "delivery_phone"
    t.integer "status", limit: 1
    t.datetime "shiped_date"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "note"
    t.string "customer_name"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_colors", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_details", charset: "utf8mb4", force: :cascade do |t|
    t.string "screen"
    t.string "system"
    t.string "rear_camera"
    t.string "front_camera"
    t.string "RAM"
    t.string "CPU"
    t.string "SIM"
    t.string "battery_capacity"
    t.integer "quantity"
    t.decimal "cost", precision: 10
    t.bigint "product_id", null: false
    t.bigint "product_color_id", null: false
    t.bigint "product_size_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_color_id"], name: "index_product_details_on_product_color_id"
    t.index ["product_id"], name: "index_product_details_on_product_id"
    t.index ["product_size_id"], name: "index_product_details_on_product_size_id"
  end

  create_table "product_sizes", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "rates", charset: "utf8mb4", force: :cascade do |t|
    t.integer "number_of_stars", limit: 1
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "comment_id", null: false
    t.index ["comment_id"], name: "index_rates_on_comment_id"
    t.index ["product_id"], name: "index_rates_on_product_id"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.string "address"
    t.string "phone"
    t.integer "role", limit: 1, default: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carts", "product_details"
  add_foreign_key "carts", "users"
  add_foreign_key "comments", "products"
  add_foreign_key "comments", "users"
  add_foreign_key "jwt_auths", "users"
  add_foreign_key "likes", "products"
  add_foreign_key "likes", "users"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "product_details"
  add_foreign_key "orders", "users"
  add_foreign_key "product_details", "product_colors"
  add_foreign_key "product_details", "product_sizes"
  add_foreign_key "product_details", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "rates", "comments"
  add_foreign_key "rates", "products"
  add_foreign_key "rates", "users"
end
