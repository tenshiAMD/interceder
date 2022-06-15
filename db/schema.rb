# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_21_153502) do

  create_table "apps", force: :cascade do |t|
    t.string "public_uid"
    t.string "name", default: "", null: false
    t.text "link", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "link"], name: "index_apps_on_name_and_link", unique: true
    t.index ["public_uid"], name: "index_apps_on_public_uid", unique: true
  end

  create_table "integrations", force: :cascade do |t|
    t.string "public_uid"
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_integrations_on_name", unique: true
    t.index ["public_uid"], name: "index_integrations_on_public_uid", unique: true
  end

  create_table "payloads", force: :cascade do |t|
    t.string "public_uid"
    t.integer "app_id", null: false
    t.text "body", default: "", null: false
    t.text "response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["app_id"], name: "index_payloads_on_app_id"
    t.index ["public_uid"], name: "index_payloads_on_public_uid", unique: true
  end

end
