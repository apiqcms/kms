ActiveRecord::Schema.define do

  # These are extensions that must be enabled in order to support this database
  # enable_extension "plpgsql"
  #
  # create_table "friendly_id_slugs", force: true do |t|
  #   t.string   "slug",                      null: false
  #   t.integer  "sluggable_id",              null: false
  #   t.string   "sluggable_type", limit: 50
  #   t.string   "scope"
  #   t.datetime "created_at"
  # end
  #
  # add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  # add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  # add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  # add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  #
  # create_table "kms_assets", force: true do |t|
  #   t.string   "file",         limit: nil
  #   t.string   "content_type", limit: nil
  #   t.datetime "created_at",               null: false
  #   t.datetime "updated_at",               null: false
  # end
  #
  # create_table "kms_pages", force: true do |t|
  #   t.string   "title",            limit: nil
  #   t.string   "slug",             limit: nil
  #   t.text     "content",                      default: ""
  #   t.boolean  "published"
  #   t.datetime "created_at",                                   null: false
  #   t.datetime "updated_at",                                   null: false
  #   t.integer  "template_id"
  #   t.string   "ancestry",         limit: nil
  #   t.string   "fullpath",         limit: nil
  #   t.boolean  "templatable",                  default: false
  #   t.string   "templatable_type", limit: nil
  #   t.boolean  "hidden",                       default: false
  #   t.integer  "position",                     default: 0,     null: false
  #   t.string   "seo_title"
  #   t.string   "seo_keywords"
  #   t.string   "seo_description"
  # end
  #
  # add_index "kms_pages", ["ancestry"], name: "index_kms_pages_on_ancestry", using: :btree
  #
  # create_table "kms_templates", force: true do |t|
  #   t.string   "name",       limit: nil
  #   t.text     "content",                default: ""
  #   t.datetime "created_at",                          null: false
  #   t.datetime "updated_at",                          null: false
  # end
  #
  # create_table "kms_users", force: true do |t|
  #   t.string   "email",                  limit: nil, default: "",    null: false
  #   t.string   "encrypted_password",     limit: nil, default: "",    null: false
  #   t.string   "reset_password_token",   limit: nil
  #   t.datetime "reset_password_sent_at"
  #   t.datetime "remember_created_at"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.string   "role",                   limit: nil
  #   t.boolean  "alert",                              default: false, null: false
  # end
  #
  # add_index "kms_users", ["email"], name: "index_kms_users_on_email", unique: true, using: :btree
  # add_index "kms_users", ["reset_password_token"], name: "index_kms_users_on_reset_password_token", unique: true, using: :btree

end
