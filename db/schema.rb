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

ActiveRecord::Schema.define(version: 20141201172610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "activity_type"
    t.json     "activity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_level"
    t.string   "uuid"
  end

  create_table "contents", force: true do |t|
    t.text     "description"
    t.integer  "media_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shareable_type"
    t.integer  "shareable_id"
    t.integer  "user_id"
    t.string   "uuid"
    t.string   "referral_tag"
  end

  create_table "media", force: true do |t|
    t.integer  "media_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.integer  "content_id"
    t.string   "uuid"
  end

  create_table "networks", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.integer  "is_friend"
    t.integer  "is_blocked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
  end

  create_table "response_maps", force: true do |t|
    t.integer  "user_id"
    t.integer  "content_id"
    t.integer  "is_inspired"
    t.integer  "did_appreciate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "inspirition_feeling"
    t.integer  "owner_id"
    t.integer  "appreciate_rating"
    t.text     "appreciate_feedback"
    t.json     "appreciation_reaction"
    t.string   "uuid"
  end

  create_table "showcases", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "state"
    t.string   "uuid"
  end

  create_table "statuses", force: true do |t|
    t.integer  "mode"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
    t.string   "uuid"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
    t.string   "username"
    t.string   "about"
  end

end
