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

ActiveRecord::Schema.define(version: 20160428013751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goals", force: :cascade do |t|
    t.string   "title",      null: false
    t.date     "due_date",   null: false
    t.boolean  "completed",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "owner"
    t.integer  "user_id",    null: false
    t.integer  "task_id"
  end

  add_index "goals", ["task_id"], name: "index_goals_on_task_id", using: :btree
  add_index "goals", ["user_id"], name: "index_goals_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "title",       null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "goal_id"
    t.boolean  "completed"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "remember_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "goals", "tasks"
  add_foreign_key "goals", "users"
end
