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

ActiveRecord::Schema.define(version: 20160611063000) do

  create_table "queries", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.text     "query_string",  limit: 65535
    t.text     "tags",          limit: 65535
    t.boolean  "is_anonymous",                default: false
    t.boolean  "is_direct",                   default: false
    t.integer  "ask_to_answer", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "query_histories", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "query_id",     limit: 4
    t.text     "query_string", limit: 65535
    t.text     "tags",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "query_id",        limit: 4
    t.integer  "user_id",         limit: 4
    t.text     "response_string", limit: 65535
    t.integer  "upvotes",         limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "urlkey",                 limit: 255
    t.string   "phone",                  limit: 255
    t.string   "gender",                 limit: 255
    t.boolean  "is_admin",                           default: false
    t.boolean  "is_trusted",                         default: false
    t.string   "batch",                  limit: 255
    t.string   "job_type",               limit: 255
    t.string   "designation",            limit: 255
    t.string   "company",                limit: 255
    t.integer  "experience_in_years",    limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
