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

ActiveRecord::Schema.define(version: 2020_10_29_155643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_students", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "student_id"
    t.integer "points"
    t.index ["course_id"], name: "index_course_students_on_course_id"
    t.index ["student_id"], name: "index_course_students_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "course_code"
    t.string "school_name"
    t.bigint "teacher_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "poms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "duration"
    t.string "link"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "course_students", "courses"
  add_foreign_key "course_students", "students"
  add_foreign_key "courses", "teachers"
end
