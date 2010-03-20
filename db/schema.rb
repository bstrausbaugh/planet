# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100309050928) do

  create_table "iterations", :force => true do |t|
    t.integer  "project_id",  :limit => 0
    t.string   "name"
    t.text     "description"
    t.date     "start_on"
    t.date     "end_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "userid"
    t.string   "name"
    t.string   "email"
    t.string   "initials"
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "iteration_id", :limit => 0
    t.integer  "tracker_id",   :limit => 0
    t.integer  "customer_id",  :limit => 0
    t.integer  "estimate",     :limit => 0
    t.integer  "priority",     :limit => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "type"
    t.string   "disposition"
    t.integer  "acceptor_id", :limit => 0
    t.integer  "estimate",    :limit => 0
    t.boolean  "complete"
    t.integer  "story_id",    :limit => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_entries", :force => true do |t|
    t.integer  "duration",   :limit => 0
    t.integer  "person1_id", :limit => 0
    t.integer  "person2_id", :limit => 0
    t.integer  "task_id",    :limit => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
