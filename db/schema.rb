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

ActiveRecord::Schema.define(version: 20160806065935) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.text     "comment_string", limit: 65535
    t.integer  "post_type",      limit: 4
    t.integer  "upvotes",        limit: 4,     default: 0
    t.integer  "post_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["post_type"], name: "index_comments_on_post_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "faqs", force: :cascade do |t|
    t.text     "question",   limit: 65535
    t.text     "answer",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_posts", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.string   "company_name",          limit: 255,   default: ""
    t.string   "company_website",       limit: 255,   default: ""
    t.string   "position",              limit: 255,   default: ""
    t.string   "compensation",          limit: 255,   default: ""
    t.integer  "experience_in_months",  limit: 4
    t.integer  "bond_period_in_months", limit: 4
    t.string   "location",              limit: 255,   default: ""
    t.string   "reporting_date_time",   limit: 255,   default: ""
    t.text     "eligibility_criteria",  limit: 65535
    t.text     "selection_process",     limit: 65535
    t.text     "job_description",       limit: 65535
    t.string   "job_type",              limit: 255,   default: ""
    t.string   "other_details",         limit: 255,   default: ""
    t.boolean  "is_edited",                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_posts", ["company_name"], name: "index_job_posts_on_company_name", using: :btree
  add_index "job_posts", ["experience_in_months"], name: "index_job_posts_on_experience_in_months", using: :btree
  add_index "job_posts", ["location"], name: "index_job_posts_on_location", using: :btree
  add_index "job_posts", ["user_id"], name: "index_job_posts_on_user_id", using: :btree

  create_table "post_histories", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "post_id",      limit: 4
    t.text     "query_string", limit: 65535
    t.text     "tags",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_histories", ["post_id"], name: "index_post_histories_on_post_id", using: :btree
  add_index "post_histories", ["user_id"], name: "index_post_histories_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.text     "query_string", limit: 65535
    t.string   "tags",         limit: 255
    t.integer  "post_type",    limit: 4
    t.boolean  "is_anonymous",               default: false
    t.boolean  "is_edited",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["post_type"], name: "index_posts_on_post_type", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255,   default: ""
    t.string   "last_name",              limit: 255,   default: ""
    t.string   "username",               limit: 255,   default: ""
    t.string   "gender",                 limit: 255,   default: ""
    t.text     "bio",                    limit: 65535
    t.string   "batch",                  limit: 255,   default: ""
    t.string   "company",                limit: 255,   default: ""
    t.string   "job_type",               limit: 255,   default: ""
    t.string   "designation",            limit: 255,   default: ""
    t.integer  "experience_in_years",    limit: 4,     default: 0
    t.string   "phone",                  limit: 255,   default: ""
    t.string   "fb_link",                limit: 255,   default: ""
    t.string   "twitter_link",           limit: 255,   default: ""
    t.string   "linked_in_link",         limit: 255,   default: ""
    t.boolean  "is_admin",                             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
