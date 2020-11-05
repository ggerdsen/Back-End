# Course.destroy_all
# CourseStudent.destroy_all
# Student.destroy_all
# Teacher.destroy_all
# Pom.destroy_all
#
# class Seed
#   def self.start
#     seed = Seed.new
#     seed.seed_students_teachers_courses
#     seed.no_connect_courses
#     seed.seed_wars
#     ActiveRecord::Base.connection.tables.each do |t|
#       ActiveRecord::Base.connection.reset_pk_sequence!(t)
#     end
#   end
#
#   def seed_students_teachers_courses
#     20.times do |i|
#       Student.create!({
#         provider: "Google",
#         uid: Faker::Number.number(digits: 5),
#         email: Faker::Internet.email,
#         token: Faker::Alphanumeric.alphanumeric(number: 12),
#         refresh_token: Faker::Alphanumeric.alphanumeric(number: 12),
#         first_name: Faker::Name.first_name,
#         last_name: Faker::Name.last_name
#       })
#     end
#     10.times do |i|
#       teacher = Teacher.create!({
#         provider: "Google",
#         uid: Faker::Number.number(digits: 5),
#         email: Faker::Internet.email,
#         token: Faker::Alphanumeric.alphanumeric(number: 12),
#         refresh_token: Faker::Alphanumeric.alphanumeric(number: 12),
#         first_name: Faker::Name.first_name,
#         last_name: Faker::Name.last_name,
#         school_name: Faker::Educator.university,
#         school_district: Faker::Address.city
#       })
#       2.times do |i|
#         course = teacher.courses.create!(
#           name: Faker::Educator.subject,
#           course_code: Faker::Alphanumeric.alphanumeric(number: 8),
#           school_name: Faker::Educator.university,
#           course_points: Faker::Number.within(range: 0..100000)
#         )
#         rand(1..3).times do
#           CourseStudent.create!(course_id: course.id, student_id: Student.ids.sample, student_points: Faker::Number.within(range: 0..1000))
#         end
#       end
#     end
#   end
#
#     #sad path seeds (teachers with courses and no connections to students)
#   def no_connect_courses
#     2.times do |i|
#       teacher = Teacher.create!({
#         provider: "Google",
#         uid: Faker::Number.number(digits: 5),
#         email: Faker::Internet.email,
#         token: Faker::Alphanumeric.alphanumeric(number: 12),
#         refresh_token: Faker::Alphanumeric.alphanumeric(number: 12),
#         first_name: Faker::Name.first_name,
#         last_name: Faker::Name.last_name,
#         school_name: Faker::Educator.university,
#         school_district: Faker::Address.city
#       })
#       2.times do |i|
#         course = teacher.courses.create!(
#           name: Faker::Educator.subject,
#           course_code: Faker::Alphanumeric.alphanumeric(number: 8),
#           school_name: Faker::Educator.university,
#           course_points: Faker::Number.within(range: 0..100000)
#         )
#       end
#     end
#   end
#
#   def seed_wars
#     3.times do |i|
#       challenger = Teacher.find(Teacher.ids.sample)
#       opponent = Teacher.find(Teacher.ids.sample)
#       until challenger != opponent
#         opponent = Teacher.find(Teacher.ids.sample)
#       end
#       challenger.wars.create!({
#         challenger_course_id: challenger.id,
#         opponent_course_id: opponent.id,
#         challenger_course_points: challenger.courses.first.course_points,
#         opponent_course_points: opponent.courses.first.course_points
#         })
#     end
#   end
# end
# Seed.start