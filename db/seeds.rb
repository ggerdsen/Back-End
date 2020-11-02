# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

Student.destroy_all
Teacher.destroy_all
Course.destroy_all
CourseStudent.destroy_all
Pom.destroy_all

class Seed
  def self.start
    seed = Seed.new
    seed.generate_teachers
  end

  def generate_teachers
    students = []
    
    20.times do |i|
      students << Student.create!({
                                  provider: "Google",
                                  uid: Faker::Number.number(digits: 5),
                                  email: Faker::Internet.email,
                                  token: Faker::Alphanumeric.alphanumeric(number: 12),
                                  refresh_token: Faker::Alphanumeric.alphanumeric(number: 12),
                                  first_name: Faker::Name.first_name,
                                  last_name: Faker::Name.last_name
                                 })
    end
    5.times do |i|
      teacher = Teacher.create!({
                                  provider: "Google",
                                  uid: Faker::Number.number(digits: 5),
                                  email: Faker::Internet.email,
                                  token: Faker::Alphanumeric.alphanumeric(number: 12),
                                  refresh_token: Faker::Alphanumeric.alphanumeric(number: 12),
                                  first_name: Faker::Name.first_name,
                                  last_name: Faker::Name.last_name,
                                  school_name: Faker::Educator.university,
                                  school_district: Faker::Address.city
                               })
      3.times do |i|
        course = teacher.courses.create!({
                                         name: Faker::Educator.subject,
                                         course_code: Faker::Number.number(digits: 4),
                                         school_name: Faker::Educator.university
                                        })
          students.each do |student|
            CourseStudent.create!(
                                  course_id: course.id,
                                  student_id: student.id,
                                  points: Faker::Number.within(range: 0..1000)
                                 )
          end
      end
    end
  end
  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end
end
Seed.start