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

ActiveRecord::Schema.define(version: 2019_11_06_082612) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contents", force: :cascade do |t|
    t.datetime "date", null: false
    t.bigint "staff_id", null: false
    t.string "staff_processing_units", null: false
    t.string "type_of_action", null: false
    t.boolean "is_active", null: false
    t.bigint "base_instance_id"
    t.bigint "previous_instance_id"
    t.string "title"
    t.string "description"
    t.text "body"
    t.string "image_url"
    t.bigint "web_section_id"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_instance_id"], name: "index_contents_on_base_instance_id"
    t.index ["previous_instance_id"], name: "index_contents_on_previous_instance_id"
    t.index ["staff_id"], name: "index_contents_on_staff_id"
    t.index ["web_section_id"], name: "index_contents_on_web_section_id"
  end

  create_table "incidence_trackings", force: :cascade do |t|
    t.bigint "incidence_id", null: false
    t.bigint "staff_id", null: false
    t.string "processing_units", null: false
    t.integer "status", null: false
    t.integer "previous_status", null: false
    t.string "message"
    t.datetime "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incidence_id"], name: "index_incidence_trackings_on_incidence_id"
    t.index ["staff_id"], name: "index_incidence_trackings_on_staff_id"
  end

  create_table "incidence_types", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incidences", force: :cascade do |t|
    t.text "description", null: false
    t.string "image_url"
    t.bigint "phone_identifier_id", null: false
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.bigint "incidence_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incidence_type_id"], name: "index_incidences_on_incidence_type_id"
    t.index ["phone_identifier_id"], name: "index_incidences_on_phone_identifier_id"
  end

  create_table "interest_points", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "image_url", null: false
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phone_identifiers", force: :cascade do |t|
    t.string "phone_identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "processing_units", force: :cascade do |t|
    t.string "code", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pu_its", force: :cascade do |t|
    t.bigint "processing_unit_id", null: false
    t.bigint "incidence_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incidence_type_id"], name: "index_pu_its_on_incidence_type_id"
    t.index ["processing_unit_id"], name: "index_pu_its_on_processing_unit_id"
  end

  create_table "pu_staffs", force: :cascade do |t|
    t.bigint "staff_id", null: false
    t.bigint "processing_unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["processing_unit_id"], name: "index_pu_staffs_on_processing_unit_id"
    t.index ["staff_id"], name: "index_pu_staffs_on_staff_id"
  end

  create_table "pu_ws", force: :cascade do |t|
    t.bigint "processing_unit_id", null: false
    t.bigint "web_section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["processing_unit_id"], name: "index_pu_ws_on_processing_unit_id"
    t.index ["web_section_id"], name: "index_pu_ws_on_web_section_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.boolean "can_publish", null: false
    t.string "full_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "web_sections", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "contents", "staffs"
  add_foreign_key "contents", "web_sections"
  add_foreign_key "incidence_trackings", "incidences"
  add_foreign_key "incidence_trackings", "staffs"
  add_foreign_key "incidences", "incidence_types"
  add_foreign_key "incidences", "phone_identifiers"
  add_foreign_key "pu_its", "incidence_types"
  add_foreign_key "pu_its", "processing_units"
  add_foreign_key "pu_staffs", "processing_units"
  add_foreign_key "pu_staffs", "staffs"
  add_foreign_key "pu_ws", "processing_units"
  add_foreign_key "pu_ws", "web_sections"
end
