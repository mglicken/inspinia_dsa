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

ActiveRecord::Schema.define(version: 20180403215010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: :cascade do |t|
    t.string "name"
  end

  create_table "buckets", force: :cascade do |t|
    t.integer "nbp_id"
    t.string  "title"
    t.text    "rationale"
  end

  create_table "case_studies", force: :cascade do |t|
    t.integer "deal_id"
    t.string  "image_id"
    t.string  "name"
  end

  create_table "case_study_slides", force: :cascade do |t|
    t.integer "case_study_id"
    t.integer "slide_id"
  end

  create_table "cip_slides", force: :cascade do |t|
    t.integer "cip_id"
    t.integer "slide_id"
  end

  create_table "cips", force: :cascade do |t|
    t.string  "name"
    t.integer "deal_id"
    t.date    "cip_date"
    t.string  "image_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string  "name"
    t.float   "revenue"
    t.float   "ebitda"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.integer "phone",            limit: 8
    t.string  "web_address"
    t.text    "description"
    t.date    "description_date"
    t.string  "linkedin_url"
    t.string  "quote"
  end

  create_table "company_follows", force: :cascade do |t|
    t.integer "user_id"
    t.integer "company_id"
  end

  create_table "company_notes", force: :cascade do |t|
    t.integer "company_id"
    t.integer "note_id"
  end

  create_table "deal_follows", force: :cascade do |t|
    t.integer "user_id"
    t.integer "deal_id"
  end

  create_table "deal_people", force: :cascade do |t|
    t.integer "deal_id"
    t.integer "person_id"
    t.integer "role_id"
  end

  create_table "deals", force: :cascade do |t|
    t.string  "name"
    t.integer "company_id"
    t.string  "project_alias"
    t.integer "project_code"
  end

  create_table "favorite_slides", force: :cascade do |t|
    t.integer "user_id"
    t.integer "slide_id"
  end

  create_table "fund_companies", force: :cascade do |t|
    t.integer "fund_id"
    t.integer "company_id"
    t.date    "acquisition_date"
    t.float   "acquisition_price"
    t.string  "link"
  end

  create_table "funds", force: :cascade do |t|
    t.integer "sponsor_id"
    t.string  "name"
    t.float   "size"
    t.boolean "open"
    t.integer "open_year"
    t.integer "close_year"
    t.string  "link"
  end

  create_table "mp_slides", force: :cascade do |t|
    t.integer "mp_id"
    t.integer "slide_id"
  end

  create_table "mps", force: :cascade do |t|
    t.string  "name"
    t.integer "deal_id"
    t.date    "mp_date"
    t.string  "image_id"
  end

  create_table "nbp_companies", force: :cascade do |t|
    t.integer "nbp_id"
    t.integer "company_id"
    t.integer "bucket_id"
    t.integer "tier_id"
    t.boolean "include_strip"
    t.text    "strip"
    t.text    "note"
  end

  create_table "nbp_slides", force: :cascade do |t|
    t.integer "nbp_id"
    t.integer "slide_id"
  end

  create_table "nbp_sponsors", force: :cascade do |t|
    t.integer "nbp_id"
    t.integer "sponsor_id"
    t.boolean "featured"
  end

  create_table "nbps", force: :cascade do |t|
    t.string  "name"
    t.integer "deal_id"
    t.date    "nbp_date"
    t.string  "image_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text   "detail"
    t.date   "date"
    t.string "link"
  end

  create_table "people", force: :cascade do |t|
    t.string  "name"
    t.string  "backwards_name"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.integer "phone",          limit: 8
    t.integer "cell",           limit: 8
    t.string  "email_address"
    t.string  "image_url"
    t.boolean "employee"
    t.integer "role_id"
    t.string  "linkedin_url"
  end

  create_table "person_notes", force: :cascade do |t|
    t.integer "person_id"
    t.integer "note_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "slide_layout_slides", force: :cascade do |t|
    t.integer "slide_layout_id"
    t.integer "slide_id"
  end

  create_table "slide_layouts", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
    t.integer "deal_id"
    t.date    "date"
  end

  create_table "slide_tags", force: :cascade do |t|
    t.integer "slide_id"
    t.integer "tag_id"
  end

  create_table "slides", force: :cascade do |t|
    t.integer "number"
    t.string  "image_url"
  end

  create_table "sponsor_follows", force: :cascade do |t|
    t.integer "sponsor_id"
    t.integer "user_id"
  end

  create_table "sponsor_histories", force: :cascade do |t|
    t.integer "person_id"
    t.integer "sponsor_id"
    t.integer "role_id"
    t.boolean "current"
    t.integer "start_year"
    t.integer "end_year"
  end

  create_table "sponsor_notes", force: :cascade do |t|
    t.integer "sponsor_id"
    t.integer "note_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string  "name"
    t.string  "tier"
    t.string  "sponsor_type"
    t.integer "rco_id"
    t.integer "co_id"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.integer "phone",            limit: 8
    t.string  "web_address"
    t.text    "description"
    t.date    "description_date"
    t.string  "linkedin_url"
  end

  create_table "subsidiaries", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.date    "acquisition_date"
    t.float   "acquisition_price"
    t.string  "link"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "teaser_slides", force: :cascade do |t|
    t.integer "teaser_id"
    t.integer "slide_id"
  end

  create_table "teasers", force: :cascade do |t|
    t.string  "name"
    t.integer "deal_id"
    t.date    "teaser_date"
    t.string  "image_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "access_id"
    t.integer  "person_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "work_histories", force: :cascade do |t|
    t.integer "person_id"
    t.integer "company_id"
    t.integer "role_id"
    t.boolean "current"
    t.integer "start_year"
    t.integer "end_year"
  end

end
