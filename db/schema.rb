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

ActiveRecord::Schema.define(version: 20140611031955) do

  create_table "alert_email_queues", force: true do |t|
    t.integer "alert_id"
    t.integer "user_id"
  end

  create_table "alert_settings", force: true do |t|
    t.integer "default_points"
    t.integer "min_points_required"
    t.boolean "send_auto_email"
    t.integer "max_warnings_before_email_alert"
    t.integer "min_points_for_penalty"
    t.integer "repetition_of_mistake_before_email"
    t.integer "penalty_carried_over"
    t.integer "school_id"
  end

  create_table "alerts", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "card_offense_types", force: true do |t|
    t.string "description"
  end

  create_table "class_sections", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  create_table "guardianships", force: true do |t|
    t.integer  "user_id"
    t.integer  "guardian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", force: true do |t|
    t.string   "description"
    t.integer  "value"
    t.boolean  "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.integer  "card_offense_id", default: 1
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_points", force: true do |t|
    t.integer  "user_id"
    t.integer  "point_id"
    t.integer  "assigned_points"
    t.boolean  "is_credit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "card_offense_id", default: 1
  end

  create_table "teacher_class_relationships", force: true do |t|
    t.integer "user_id"
    t.integer "class_section_id"
    t.integer "teacher_role_id"
  end

  create_table "teacher_roles", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", force: true do |t|
    t.string   "name"
    t.datetime "term_from"
    t.datetime "term_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  create_table "user_types", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "type"
    t.integer  "enrollment_id"
    t.integer  "class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "school_id"
  end

  add_index "users", ["email"], name: "index_users_email", unique: true, using: :btree
  add_index "users", ["first_name", "last_name"], name: "index_users_names", using: :btree
  add_index "users", ["remember_token"], name: "index_users_remember_token", unique: true, using: :btree

end
