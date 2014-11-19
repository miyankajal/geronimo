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

ActiveRecord::Schema.define(version: 20141118030456) do

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

  create_table "card_offense_types", force: true do |t|
    t.string "description"
  end

  create_table "class_sections", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "idea_id"
    t.text     "comment"
    t.integer  "user_id"
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id", "idea_id", "accepted"], name: "IX_Comments", using: :btree

  create_table "guardianships", force: true do |t|
    t.integer  "user_id"
    t.integer  "guardian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideas", force: true do |t|
    t.text     "idea"
    t.integer  "user_id"
    t.integer  "moderator_id"
    t.integer  "likes_count"
    t.integer  "tag_id"
    t.integer  "portal_id",    default: 1
    t.boolean  "accepted",     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ideas", ["moderator_id", "accepted"], name: "IX_Ideas_Moderator", using: :btree
  add_index "ideas", ["portal_id"], name: "FK_Ideas_Portals", using: :btree
  add_index "ideas", ["tag_id"], name: "FK_Ideas_Tags", using: :btree
  add_index "ideas", ["user_id", "portal_id", "accepted"], name: "IX_Ideas", using: :btree

  create_table "points", force: true do |t|
    t.string   "description"
    t.integer  "value"
    t.boolean  "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.integer  "card_offense_id", default: 1
    t.integer  "key"
  end

  create_table "posting_portals", force: true do |t|
    t.string   "description", limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "tag_comment_ideas", force: true do |t|
    t.integer  "tag_id"
    t.integer  "comment_id"
    t.integer  "idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_comment_ideas", ["tag_id", "comment_id", "idea_id"], name: "index_tag_comment_ideas_on_tag_id_and_comment_id_and_idea_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "description", limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.integer  "points"
  end

  add_index "tags", ["id"], name: "FK_Tags", using: :btree

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

  create_table "user_idea_relationships", force: true do |t|
    t.integer  "idea_id"
    t.integer  "user_id"
    t.boolean  "like"
    t.boolean  "report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_idea_relationships", ["idea_id", "user_id"], name: "IX_User_Idea", using: :btree

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
  add_index "users", ["id"], name: "FK_Users", using: :btree
  add_index "users", ["remember_token"], name: "index_users_remember_token", unique: true, using: :btree

end
