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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130715074618) do

  create_table "ignored_moments", :force => true do |t|
    t.integer  "moment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interactive_filters", :force => true do |t|
    t.string   "icon_file",                                  :null => false
    t.integer  "moment_id",                   :default => 0, :null => false
    t.string   "moment_name"
    t.string   "filter_file"
    t.integer  "del_flg",       :limit => 1,  :default => 0, :null => false
    t.string   "name",          :limit => 50
    t.text     "description",                                :null => false
    t.datetime "created_at",                                 :null => false
    t.text     "vshader",                                    :null => false
    t.text     "fshader",                                    :null => false
    t.integer  "order"
    t.string   "filter_params"
    t.integer  "version"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "user_id"
    t.string   "code",          :limit => 200
    t.integer  "allowed_count",                :default => 1
    t.integer  "used_count",                   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "last_views", :force => true do |t|
    t.integer  "user_id",                                         :null => false
    t.datetime "user_created_at"
    t.datetime "user_last_active_at"
    t.integer  "days_lived",                       :default => 0, :null => false
    t.integer  "seconds_lived",       :limit => 8
  end

  add_index "last_views", ["user_id"], :name => "user_id"

  create_table "likes", :force => true do |t|
    t.integer  "user_id",                                 :null => false
    t.integer  "activity_id"
    t.integer  "moment_id"
    t.datetime "created_at",                              :null => false
    t.integer  "fake",        :limit => 1, :default => 0
  end

  add_index "likes", ["activity_id"], :name => "activity_id"
  add_index "likes", ["created_at"], :name => "created_at"
  add_index "likes", ["moment_id"], :name => "moment_id"
  add_index "likes", ["user_id", "activity_id", "fake"], :name => "user_id"
  add_index "likes", ["user_id", "moment_id"], :name => "user_id_2"

  create_table "lnglat_offsets", :force => true do |t|
    t.decimal "lng",        :precision => 18, :scale => 2, :null => false
    t.decimal "lat",        :precision => 18, :scale => 2, :null => false
    t.float   "offset_x",                                  :null => false
    t.float   "offset_y",                                  :null => false
    t.float   "offset_lng",                                :null => false
    t.float   "offset_lat",                                :null => false
  end

  add_index "lnglat_offsets", ["lng", "lat"], :name => "lng"

  create_table "lucky_draws", :force => true do |t|
    t.integer  "moment_id"
    t.string   "name"
    t.integer  "total"
    t.integer  "used"
    t.integer  "priority"
    t.integer  "possibility"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "apply_city"
  end

  create_table "moment_importations", :force => true do |t|
    t.string   "imported_type", :limit => 200, :null => false
    t.integer  "imported_id",                  :null => false
    t.integer  "moment_id",                    :null => false
    t.datetime "created_at"
  end

  create_table "moment_statistics", :force => true do |t|
    t.integer  "moment_id"
    t.integer  "shared_count", :default => 0
    t.integer  "played_count", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "total_score"
    t.integer  "user_id"
  end

  add_index "moment_statistics", ["created_at"], :name => "index_moment_statistics_on_created_at"
  add_index "moment_statistics", ["moment_id"], :name => "index_moment_statistics_on_moment_id"
  add_index "moment_statistics", ["total_score"], :name => "index_moment_statistics_on_total_score"
  add_index "moment_statistics", ["user_id"], :name => "index_moment_statistics_on_user_id"

  create_table "moments", :force => true do |t|
    t.string   "name",                                  :limit => 200
    t.integer  "name_modified_by_user",                 :limit => 1,   :default => 0
    t.string   "address",                               :limit => 500
    t.string   "political_country",                     :limit => 500
    t.string   "political_administrative_area_level_1", :limit => 500
    t.string   "political_locality",                    :limit => 500
    t.string   "political_sublocality",                 :limit => 500
    t.integer  "category_id",                                          :default => 0
    t.float    "lng"
    t.float    "lat"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "modified_at"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "participants_count"
    t.integer  "photos_count"
    t.integer  "videos_count",                                         :default => 0
    t.integer  "likes_count",                                          :default => 0, :null => false
    t.integer  "comments_count",                                       :default => 0, :null => false
    t.integer  "score"
    t.integer  "del_flg",                               :limit => 1,   :default => 0
    t.integer  "moment_type",                                          :default => 0
    t.integer  "display_order",                         :limit => 1,   :default => 0
    t.string   "cover"
    t.integer  "privacy",                               :limit => 1,   :default => 0, :null => false
    t.text     "description"
    t.datetime "updated_at"
  end

  add_index "moments", ["category_id"], :name => "category_id"
  add_index "moments", ["del_flg", "photos_count"], :name => "photos_count"
  add_index "moments", ["del_flg"], :name => "del_flg"
  add_index "moments", ["ends_at"], :name => "ends_at"
  add_index "moments", ["id", "name"], :name => "id"
  add_index "moments", ["id", "privacy"], :name => "id_3"
  add_index "moments", ["lng", "lat", "created_at"], :name => "lng_2"
  add_index "moments", ["lng", "lat"], :name => "lng"
  add_index "moments", ["modified_at", "privacy"], :name => "modified_at"
  add_index "moments", ["moment_type", "display_order", "id"], :name => "id_2"
  add_index "moments", ["user_id", "del_flg", "name_modified_by_user", "created_at"], :name => "name_modified_by_user"
  add_index "moments", ["user_id", "name"], :name => "name"

  create_table "notification_reports", :force => true do |t|
    t.integer  "notification_id"
    t.integer  "user_id"
    t.string   "token"
    t.integer  "received",        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id",                                       :null => false
    t.datetime "created_at",                                    :null => false
    t.integer  "is_read",           :limit => 1, :default => 0, :null => false
    t.string   "title"
    t.text     "html"
    t.integer  "notification_type"
    t.integer  "actor_id"
    t.integer  "subject1_id"
    t.integer  "subject2_id"
    t.text     "links"
    t.integer  "sent",              :limit => 1, :default => 1, :null => false
    t.integer  "skip_push",         :limit => 1, :default => 0
  end

  add_index "notifications", ["actor_id", "user_id", "subject1_id"], :name => "actor_id"
  add_index "notifications", ["user_id", "is_read"], :name => "user_id"
  add_index "notifications", ["user_id", "notification_type", "subject1_id"], :name => "user_id_2"

  create_table "photos", :force => true do |t|
    t.integer  "photoable_id"
    t.string   "photoable_type",  :limit => 100
    t.integer  "parent_id"
    t.integer  "user_id"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "content_type",    :limit => 100
    t.string   "filename",        :limit => 300
    t.string   "thumbnail",       :limit => 300
    t.string   "upload_filename", :limit => 300
    t.string   "orig_filename",   :limit => 300
    t.integer  "validated",       :limit => 1,   :default => 0
    t.integer  "isvalid",         :limit => 1,   :default => 0
    t.integer  "del_flg",                        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "md5",             :limit => 50
    t.text     "description"
    t.string   "partition",       :limit => 20
  end

  add_index "photos", ["md5"], :name => "md5"
  add_index "photos", ["parent_id", "thumbnail"], :name => "parent_id", :length => {"parent_id"=>nil, "thumbnail"=>255}
  add_index "photos", ["photoable_id", "photoable_type", "del_flg", "validated", "isvalid"], :name => "photoable_id"
  add_index "photos", ["photoable_id", "photoable_type", "id"], :name => "id"

  create_table "places", :force => true do |t|
    t.integer  "region_id"
    t.integer  "category_id"
    t.integer  "brand_id"
    t.integer  "type_id"
    t.integer  "subtype_id"
    t.integer  "section_id"
    t.string   "name",         :limit => 300,                :null => false
    t.integer  "rentable",     :limit => 1,   :default => 0, :null => false
    t.string   "address",      :limit => 300
    t.string   "address_t",    :limit => 300
    t.string   "crossstreet",  :limit => 300
    t.string   "phone1",       :limit => 100
    t.string   "phone1_t",     :limit => 100
    t.string   "phone2",       :limit => 100
    t.integer  "got_lnglat",   :limit => 1,   :default => 0, :null => false
    t.integer  "user_id",                     :default => 0, :null => false
    t.integer  "price",                       :default => 0, :null => false
    t.datetime "created_at"
    t.integer  "v_flg",        :limit => 1,   :default => 0
    t.integer  "verified_flg", :limit => 1,   :default => 0
    t.integer  "del_flg",      :limit => 1,   :default => 0
  end

  add_index "places", ["subtype_id"], :name => "subtype_id"

  create_table "poiings", :force => true do |t|
    t.integer  "poi_id"
    t.integer  "poiable_id"
    t.string   "poiable_type"
    t.integer  "del_flg",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pois", :force => true do |t|
    t.integer  "remote_poi_id"
    t.integer  "del_flg",         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_poi_name"
    t.float    "lng"
    t.float    "lat"
    t.string   "city"
    t.string   "poi_type"
  end

  create_table "pois_tags", :id => false, :force => true do |t|
    t.integer  "poi_id"
    t.integer  "tag_id"
    t.integer  "del_flg",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pulses", :force => true do |t|
    t.integer  "processed",  :limit => 1, :default => 0, :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "qq_coins", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.string   "password"
    t.integer  "coins"
    t.boolean  "is_used",    :default => false
  end

  create_table "recommendations", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.string   "img_url"
    t.string   "download_url"
    t.string   "platform"
    t.integer  "display_order", :default => 0
    t.integer  "del_flg",       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name",       :limit => 200, :null => false
    t.string   "fullname",   :limit => 200
    t.float    "lng",                       :null => false
    t.float    "lat",                       :null => false
    t.integer  "user_id"
    t.datetime "created_at"
  end

  create_table "remote_friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "remote_user_id"
    t.string   "status",         :limit => 20
    t.integer  "del_flg",        :limit => 1,  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remote_friendships", ["del_flg", "user_id", "remote_user_id"], :name => "user_id_2"
  add_index "remote_friendships", ["remote_user_id", "updated_at"], :name => "remote_user_id"
  add_index "remote_friendships", ["user_id"], :name => "user_id_3"

  create_table "remote_users", :force => true do |t|
    t.string   "remote_site",        :limit => 10
    t.string   "remote_site_id",     :limit => 100
    t.string   "remote_site_name",   :limit => 200
    t.string   "remote_site_avatar"
    t.integer  "is_vida_user",       :limit => 1,   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "del_flg",            :limit => 1,   :default => 0
  end

  add_index "remote_users", ["remote_site", "remote_site_id"], :name => "remote_site"
  add_index "remote_users", ["remote_site"], :name => "remote_site_2"
  add_index "remote_users", ["remote_site_id"], :name => "remote_site_id"

  create_table "reports", :force => true do |t|
    t.integer  "report_type", :limit => 1
    t.integer  "user_id"
    t.string   "email"
    t.string   "user_ip",     :limit => 20
    t.string   "mobile",      :limit => 20
    t.text     "content"
    t.datetime "created_at"
  end

  create_table "robots", :primary_key => "robot_id", :force => true do |t|
    t.integer  "id",                                                       :null => false
    t.string   "name",                                                     :null => false
    t.datetime "created_at",                                               :null => false
    t.integer  "following_limited",         :limit => 1,  :default => 0,   :null => false
    t.datetime "robot_refreshed_at",                                       :null => false
    t.integer  "robot_sex",                               :default => 0,   :null => false
    t.string   "robot_token",                                              :null => false
    t.string   "robot_secret",                                             :null => false
    t.string   "robot_devicetoken",                                        :null => false
    t.integer  "robot_disabled",            :limit => 1,  :default => 0,   :null => false
    t.datetime "robot_last_executed_at"
    t.datetime "robot_last_preexecuted_at"
    t.integer  "robot_interval_hours",                    :default => 0
    t.float    "robot_stability",                         :default => 1.0, :null => false
    t.integer  "robot_photo_type",                        :default => 0
    t.string   "crawl_url",                 :limit => 50
  end

  add_index "robots", ["id"], :name => "id", :unique => true
  add_index "robots", ["robot_last_preexecuted_at"], :name => "B"
  add_index "robots", ["robot_photo_type"], :name => "Type"

  create_table "se_agents", :force => true do |t|
    t.string "name", :limit => 400
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string  "skey",        :limit => 100
    t.integer "svalue"
    t.string  "description", :limit => 100
  end

  create_table "short_urls", :force => true do |t|
    t.string    "to_url",     :limit => 1023, :default => "http://molitown.com/", :null => false
    t.string    "name"
    t.integer   "count",                      :default => 0,                      :null => false
    t.timestamp "created_at",                                                     :null => false
  end

  create_table "sina_moments", :force => true do |t|
    t.integer  "sina_id",         :limit => 8
    t.integer  "user_id"
    t.text     "content"
    t.float    "lng"
    t.float    "lat"
    t.integer  "comments_count"
    t.integer  "rt_count"
    t.string   "img_url",         :limit => 500
    t.datetime "sina_created_at"
    t.datetime "created_at"
  end

  create_table "sommeliers", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spiders", :force => true do |t|
    t.string "name", :limit => 400, :null => false
  end

  create_table "stat_keys", :force => true do |t|
    t.string   "key_name"
    t.string   "key_calculation"
    t.string   "key_description"
    t.datetime "happened_at"
  end

  create_table "stats", :force => true do |t|
    t.string   "s_key",      :limit => 100, :null => false
    t.string   "s_value",    :limit => 100, :null => false
    t.datetime "created_at",                :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "user_id"
    t.integer  "subscription_type", :default => 0
    t.integer  "del_flg",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sync_histories", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.string   "site",           :limit => 10,  :null => false
    t.integer  "activity_type",  :limit => 1
    t.integer  "activity_id"
    t.text     "content"
    t.string   "remote_site_id", :limit => 100
    t.text     "remote_text"
    t.text     "remote_pic"
    t.datetime "created_at",                    :null => false
    t.integer  "comments_count"
    t.integer  "reposts_count"
    t.string   "type"
    t.integer  "moment_id"
    t.integer  "sent"
  end

  add_index "sync_histories", ["site", "remote_site_id"], :name => "site"
  add_index "sync_histories", ["user_id", "site"], :name => "user_id"

  create_table "sysmessages", :force => true do |t|
    t.string "skey",   :limit => 100, :null => false
    t.string "svalue", :limit => 100, :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.integer  "del_flg",       :limit => 1, :default => 0
    t.integer  "user_id",                    :default => 0, :null => false
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "del_flg"], :name => "taggable_id"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "tag_type",           :default => 0
    t.integer "subscription_count", :default => 0
    t.integer "display_order",      :default => 0
  end

  add_index "tags", ["name"], :name => "name"

  create_table "template_datas", :force => true do |t|
    t.string  "template_dataable_type", :limit => 100
    t.integer "template_dataable_id"
    t.integer "s_key"
    t.text    "s_value"
  end

  create_table "user_auths", :force => true do |t|
    t.integer  "user_id",                                          :null => false
    t.string   "auth_site",          :limit => 10
    t.string   "auth_user_id",       :limit => 200
    t.string   "auth_user_name",     :limit => 200
    t.string   "token",              :limit => 100
    t.string   "secret",             :limit => 100
    t.string   "refresh_token",      :limit => 100
    t.datetime "refreshed_at"
    t.integer  "expires_in",         :limit => 8
    t.datetime "to_be_refreshed_at"
    t.integer  "del_flg",            :limit => 1,   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sync_necessary",     :limit => 1,   :default => 0
    t.string   "auth_site_album_id", :limit => 200
  end

  add_index "user_auths", ["auth_site"], :name => "auth_site"
  add_index "user_auths", ["auth_user_id"], :name => "auth_user_id"
  add_index "user_auths", ["user_id"], :name => "user_id"

  create_table "user_belongings", :force => true do |t|
    t.integer  "user_id"
    t.string   "belongers",  :limit => 200
    t.datetime "created_at"
  end

  create_table "user_details", :force => true do |t|
    t.integer  "user_id"
    t.integer  "moments_count"
    t.integer  "followings_count"
    t.integer  "followers_count"
    t.integer  "likes_count"
    t.integer  "comments_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notification_report", :default => 0
  end

  create_table "user_lucky_draws", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lucky_draw_id"
    t.text     "address"
    t.string   "postcode"
    t.string   "city"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "moment_id"
  end

  create_table "user_shuffles", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "qq_coin_id"
    t.integer  "shuffle_result"
  end

  add_index "user_shuffles", ["created_at"], :name => "index_user_shuffles_on_created_at"
  add_index "user_shuffles", ["user_id"], :name => "index_user_shuffles_on_user_id"

  create_table "user_statistic_totals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "create_score"
    t.integer  "share_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_award",            :default => false
    t.integer  "award_type",          :default => 1
    t.datetime "award_time"
    t.string   "award_share_url"
    t.integer  "create_count",        :default => 0
    t.integer  "create_played_count", :default => 0
    t.integer  "shared_count",        :default => 0
    t.integer  "shared_played_count", :default => 0
    t.text     "create_moment_ids"
    t.text     "share_moment_ids"
  end

  add_index "user_statistic_totals", ["is_award"], :name => "index_user_statistic_totals_on_is_award"
  add_index "user_statistic_totals", ["user_id"], :name => "index_user_statistic_totals_on_user_id"

  create_table "user_statistics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "create_count",        :default => 0
    t.integer  "create_played_count", :default => 0
    t.integer  "shared_count",        :default => 0
    t.integer  "shared_played_count", :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "create_score"
    t.integer  "share_score"
  end

  add_index "user_statistics", ["create_score"], :name => "index_user_statistics_on_create_score"
  add_index "user_statistics", ["created_at", "user_id"], :name => "index_user_statistics_on_created_at_and_user_id"
  add_index "user_statistics", ["share_score"], :name => "index_user_statistics_on_share_score"
  add_index "user_statistics", ["user_id"], :name => "index_user_statistics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",                                                           :null => false
    t.integer  "gender",                    :limit => 1,   :default => 0,        :null => false
    t.string   "email",                                                          :null => false
    t.string   "phone",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.integer  "reset_password"
    t.string   "reset_id",                  :limit => 40
    t.datetime "reset_at"
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "default_password",          :limit => 100
    t.string   "got_from",                  :limit => 10
    t.float    "lng"
    t.float    "lat"
    t.datetime "located_at"
    t.datetime "last_post_at"
    t.string   "theme_color",               :limit => 6,   :default => "E5253B"
    t.string   "region_name",               :limit => 200
    t.string   "version",                   :limit => 200
    t.integer  "followers_count"
    t.string   "lang",                      :limit => 10,  :default => "zh"
    t.string   "register_uuid"
    t.integer  "recommended",               :limit => 1,   :default => 0,        :null => false
    t.integer  "following_limited",         :limit => 1,   :default => 0,        :null => false
  end

  add_index "users", ["created_at"], :name => "created_at"
  add_index "users", ["email", "id"], :name => "id"
  add_index "users", ["email"], :name => "email"
  add_index "users", ["got_from"], :name => "got_from"
  add_index "users", ["lng", "lat", "located_at"], :name => "lng"
  add_index "users", ["name"], :name => "name"
  add_index "users", ["recommended"], :name => "recommended"
  add_index "users", ["register_uuid"], :name => "register_uuid"

  create_table "vender_relationships", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.string   "vender",        :limit => 50, :null => false
    t.text     "following_ids"
    t.text     "follower_ids"
    t.datetime "created_at",                  :null => false
  end

  add_index "vender_relationships", ["user_id"], :name => "user_id"
  add_index "vender_relationships", ["vender"], :name => "vender"

  create_table "vendor_avatars", :force => true do |t|
    t.integer  "user_id"
    t.string   "from_site",  :limit => 200
    t.string   "img_url",    :limit => 200
    t.integer  "del_flg",    :limit => 1,   :default => 0
    t.datetime "created_at"
  end

  add_index "vendor_avatars", ["del_flg", "from_site", "user_id"], :name => "user_id"

  create_table "versions", :force => true do |t|
    t.string   "platform",     :limit => 20,  :null => false
    t.float    "ver",                         :null => false
    t.string   "version_name", :limit => 200
    t.string   "content",      :limit => 200
    t.string   "url",          :limit => 200
    t.datetime "created_at",                  :null => false
    t.integer  "minimum"
  end

  create_table "videos", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.text     "description"
    t.integer  "transcoded",      :limit => 1,   :default => 0
    t.integer  "failed",          :limit => 1,   :default => 0
    t.integer  "validated",       :limit => 1,   :default => 0
    t.integer  "isvalid",         :limit => 1,   :default => 0
    t.string   "upload_filename", :limit => 200
    t.string   "orig_filename",   :limit => 200
    t.string   "dest_filename",   :limit => 200
    t.integer  "invalid_reason",  :limit => 1,   :default => 0
    t.integer  "del_flg",                        :default => 0
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "md5",             :limit => 50
    t.integer  "width"
    t.integer  "height"
    t.string   "partition",       :limit => 20
  end

  add_index "videos", ["activity_id", "md5"], :name => "activity_id_2"
  add_index "videos", ["activity_id"], :name => "activity_id"
  add_index "videos", ["md5"], :name => "md5"

  create_table "weibo_apps", :force => true do |t|
    t.string   "name",       :limit => 200, :null => false
    t.integer  "count",                     :null => false
    t.datetime "created_at",                :null => false
  end

end
