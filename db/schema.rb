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

ActiveRecord::Schema.define(version: 20150128092652) do

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
    t.string   "uuid"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "media_maps", force: true do |t|
    t.integer  "media_id"
    t.integer  "type_id"
    t.string   "type_name"
    t.string   "media_url"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "performances", force: true do |t|
    t.integer  "showcase_id"
    t.string   "showcase_title"
    t.string   "showcase_bg_url"
    t.string   "showcase_media_url"
    t.integer  "showcase_media_type"
    t.integer  "showcase_total_appreciations"
    t.integer  "showcase_total_skips"
    t.string   "showcase_user_name"
    t.string   "showcase_user_avatar_url"
    t.datetime "showcase_created_at"
    t.integer  "showcase_rank"
    t.decimal  "showcase_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "redirects", force: true do |t|
    t.string   "token"
    t.string   "long_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "response_maps", force: true do |t|
    t.integer  "user_id"
    t.integer  "content_id"
    t.integer  "is_inspired"
    t.integer  "did_appreciate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.json     "appreciation_reaction"
    t.string   "uuid"
    t.json     "inspiration_response"
    t.integer  "content_type"
  end

  create_table "showcase_queues", force: true do |t|
    t.integer  "showcase_id"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "title"
    t.string   "user_avatar_url"
    t.integer  "total_appreciations"
    t.integer  "total_skips"
    t.string   "bg_url"
    t.string   "media_url"
    t.integer  "media_type"
  end

  create_table "showcase_tasks", force: true do |t|
    t.string   "cron"
    t.integer  "content_limit"
    t.datetime "last_timestamp"
    t.integer  "last_timestamp_epoch"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "random_token"
  end

end
