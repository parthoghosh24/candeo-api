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

ActiveRecord::Schema.define(version: 20150624183744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_type"
    t.json     "activity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_level"
    t.string   "uuid",           limit: 255
  end

  create_table "content_media_maps", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "content_id"
  end

  create_table "contents", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shareable_type", limit: 255
    t.integer  "shareable_id"
    t.integer  "user_id"
    t.string   "uuid",           limit: 255
    t.string   "referral_tag",   limit: 255
  end

  create_table "media", force: :cascade do |t|
    t.integer  "media_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",                    limit: 255
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "media_maps", force: :cascade do |t|
    t.integer  "media_id"
    t.string   "media_url",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attachable_id"
    t.string   "attachable_type", limit: 255
    t.string   "uuid",            limit: 255
  end

  create_table "networks", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.integer  "is_friend"
    t.integer  "is_blocked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",        limit: 255
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "performances", force: :cascade do |t|
    t.integer  "showcase_id"
    t.string   "showcase_title",               limit: 255
    t.integer  "showcase_media_type"
    t.integer  "showcase_total_appreciations"
    t.integer  "showcase_total_skips"
    t.datetime "showcase_created_at"
    t.integer  "showcase_rank"
    t.decimal  "showcase_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_showcase_copyrighted"
    t.integer  "showcase_top_rank"
    t.boolean  "is_showcase_archived"
  end

  create_table "rank_maps", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "rank"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "redirects", force: :cascade do |t|
    t.string   "token",      limit: 255
    t.string   "long_url",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "response_maps", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "is_inspired"
    t.integer  "has_appreciated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.json     "appreciation_response"
    t.string   "uuid",                  limit: 255
    t.json     "inspiration_response"
    t.integer  "content_type"
    t.integer  "showcase_id"
    t.integer  "status_id"
    t.boolean  "has_skipped"
    t.json     "skip_response"
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.string   "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

  create_table "shout_discussions", force: :cascade do |t|
    t.integer  "shout_id"
    t.integer  "user_id"
    t.json     "discussion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shout_participants", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shout_id"
    t.boolean  "is_owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shouts", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.boolean  "is_public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "showcase_caps", force: :cascade do |t|
    t.integer  "quota"
    t.datetime "end_time"
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "showcase_queues", force: :cascade do |t|
    t.integer  "showcase_id"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",               limit: 255
    t.integer  "media_type"
    t.integer  "total_appreciations"
    t.integer  "total_skips"
    t.boolean  "is_copyrighted"
  end

  create_table "showcase_tasks", force: :cascade do |t|
    t.string   "cron",                 limit: 255
    t.integer  "content_limit"
    t.datetime "last_timestamp"
    t.integer  "last_timestamp_epoch"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_rank"
  end

  create_table "showcases", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "state"
    t.string   "uuid",           limit: 255
    t.boolean  "is_copyrighted"
  end

  create_table "statuses", force: :cascade do |t|
    t.integer  "mode"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag",        limit: 255
    t.string   "uuid",       limit: 255
  end

  create_table "user_media_maps", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "email",               limit: 255
    t.string   "auth_token",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",                limit: 255
    t.string   "username",            limit: 255
    t.string   "about",               limit: 255
    t.integer  "random_token"
    t.integer  "total_appreciations"
    t.integer  "total_inspires"
    t.boolean  "has_posted"
    t.string   "gcm_id"
  end

end
