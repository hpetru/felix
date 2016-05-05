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

ActiveRecord::Schema.define(version: 20160505064658) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "semesters", force: :cascade do |t|
    t.integer  "year",          null: false
    t.string   "semester_type", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "student_anual_grades", force: :cascade do |t|
    t.integer  "subject_id", null: false
    t.float    "value",      null: false
    t.integer  "year",       null: false
    t.integer  "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_groups", force: :cascade do |t|
    t.integer  "promotion",       null: false
    t.string   "suffix",          null: false
    t.string   "profile_slug"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "main_teacher_id", null: false
  end

  create_table "student_semester_grades", force: :cascade do |t|
    t.float    "value",       null: false
    t.integer  "subject_id",  null: false
    t.integer  "student_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "semester_id", null: false
  end

  create_table "student_thesis_grades", force: :cascade do |t|
    t.integer  "student_id",  null: false
    t.integer  "value",       null: false
    t.integer  "subject_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "semester_id", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name",       null: false
    t.string   "last_name",        null: false
    t.integer  "student_group_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "students", ["student_group_id"], name: "index_students_on_student_group_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "first_name",                         null: false
    t.string   "last_name",                          null: false
    t.date     "birthday",                           null: false
    t.string   "phone"
    t.string   "degree"
    t.string   "graduated_from"
    t.integer  "degree_reeval_year"
    t.boolean  "retired",            default: false
    t.boolean  "sindicate_member",   default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "teaching_subjects", force: :cascade do |t|
    t.integer  "teacher_id",       null: false
    t.integer  "student_group_id", null: false
    t.integer  "subject_id",       null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "students", "student_groups"
end
