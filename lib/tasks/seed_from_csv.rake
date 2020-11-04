require 'csv'

namespace :csv_import do
  desc 'Seed csv data from db/csv_files to database table'
  # To call this, use in command line: rake csv_import:seedCSV
  task seedCSV: :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    puts('Database destroyed, created, and migrated')

    def read_csv(resource)
      file = "db/csv_seeds/#{resource}.csv"
      CSV.read(file, headers: true, header_converters: :symbol)
    end

    read_csv('students').each do |line|
      Student.create!(
        id: line[:id],
        provider: line[:provider],
        uid: line[:uid],
        email: line[:email],
        token: line[:token],
        refresh_token: line[:refresh_token],
        first_name: line[:first_name],
        last_name: line[:last_name]
      )
    end
    puts('Student: File imported')

    read_csv('teachers').each do |line|
      Teacher.create!(
        id: line[:id],
        provider: line[:provider],
        uid: line[:uid],
        email: line[:email],
        token: line[:token],
        refresh_token: line[:refresh_token],
        first_name: line[:first_name],
        last_name: line[:last_name],
        school_name: line[:school_name],
        school_district: line[:school_district]
      )
    end
    puts('Teacher: File imported')

    read_csv('courses').each do |line|
      Course.create!(
        id: line[:id],
        name: line[:name],
        course_code: line[:course_code],
        course_points: line[:course_points].to_i,
        school_name: line[:school_name].to_i,
        teacher: Teacher.find(line[:teacher_id].to_i)
      )
    end
    puts('Course: File imported')

    read_csv('course_students').each do |line|
      CourseStudent.create!(
        id: line[:id],
        course: Course.find(line[:course_id].to_i),
        student: Student.find(line[:student_id].to_i),
        student_points: line[:student_points].to_i
      )
    end
    puts('CourseStudent: File imported')


    read_csv('wars').each do |line|
      War.create!(
        id: line[:id],
        challenger_course_id: line[:challenger_course_id],
        opponent_course_id: line[:opponent_course_id],
        challenger_course_points: line[:challenger_course_points],
        opponent_course_points: line[:opponent_course_points],
        teacher: Teacher.find(line[:teacher_id].to_i)
      )
    end
    puts('War: File imported')

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    puts('Primary Keys reset')
  end
end
