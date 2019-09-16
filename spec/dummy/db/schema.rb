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

ActiveRecord::Schema.define(version: 2019_09_03_161741) do

  create_table "questionable_answers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "assignment_id"
    t.integer "option_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.index ["assignment_id"], name: "index_questionable_answers_on_assignment_id"
    t.index ["option_id"], name: "index_questionable_answers_on_option_id"
    t.index ["question_id"], name: "index_questionable_answers_on_question_id"
    t.index ["user_id"], name: "index_questionable_answers_on_user_id"
  end

  create_table "questionable_assignments", force: :cascade do |t|
    t.integer "question_id"
    t.integer "subject_id"
    t.string "subject_type"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_type", "subject_id", "position"], name: "index_questionable_assignments_on_subject_and_position"
  end

  create_table "questionable_options", force: :cascade do |t|
    t.integer "question_id"
    t.string "title"
    t.string "note"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "position"], name: "index_questionable_options_on_question_id_and_position"
  end

  create_table "questionable_questions", force: :cascade do |t|
    t.string "category", limit: 255
    t.string "title", limit: 255
    t.string "note", limit: 255
    t.string "input_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questionable_subjects", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_questionable_subjects_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
  end

end
