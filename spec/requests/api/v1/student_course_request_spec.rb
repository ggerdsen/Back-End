
require 'rails_helper'

RSpec.describe 'student courses' do

  it 'creates a new student course' do
    teacher = create(:teacher)
    course = teacher.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher.id,
      course_points: 0
    })
    student = create(:student)

    student_course_params = ({
      course_id: course.id,
      student_id: student.id,
      student_points: 0
    })
    post "/api/v1/students/courses", params: student_course_params

    expect(response).to be_successful
    returned_student_course = JSON.parse(response.body, symbolize_names: true)
    expect(returned_student_course[:data][:attributes][:course_id].to_i).to eq(course.id)

    student_course_in_database = CourseStudent.last
    expect(student_course_in_database.course_id).to eq(course.id)
  end

  it 'can display all courses a student is currently enrolled in' do
    teacher1 = create(:teacher)
    course1 = teacher1.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher1.id,
      course_points: 0
    })
    teacher2 = create(:teacher)
    course2 = teacher2.courses.create({
      name: 'Forensic Psychology',
      course_code: '1234abcd',
      school_name: 'Hogwarts High School',
      teacher_id: teacher2.id,
      course_points: 0
    })
    not_enrolled_course = teacher2.courses.create({
      name: 'You Shouldnt See Me',
      course_code: '1a2b3c4d',
      school_name: 'Hogwarts High School',
      teacher_id: teacher2.id,
      course_points: 0
    })
    student = create(:student)

    student.course_students.create(course_id: course1.id, student_points: 0)
    student.course_students.create(course_id: course2.id, student_points: 0)
    student_course_params = ({student_id: student.id})
    get "/api/v1/students/courses", params: student_course_params
    expect(response).to be_successful

    returned_courses = JSON.parse(response.body, symbolize_names: true)
    expect(returned_courses[:data][0][:id].to_i).to eq(course1.id)
    expect(returned_courses[:data][0][:attributes][:name]).to eq(course1[:name])

    expect(returned_courses[:data][1][:id].to_i).to eq(course2.id)
    expect(returned_courses[:data][1][:attributes][:name]).to eq(course2[:name])

    expect(returned_courses[:data].count).to eq(2)
  end

  it 'can unenroll a student from a course' do
    teacher = create(:teacher)

    course = teacher.courses.create({
      name: 'You Should See Me',
      course_code: '1a2b3c4d',
      school_name: 'Hogwarts High School',
      teacher_id: teacher.id,
      course_points: 0
    })
    student = create(:student)

    student.course_students.create(course_id: course.id, student_points: 0)

    student_course_params = ({
        course_id: course.id,
        student_id: student.id,
        student_points: 0
      })
    expect(CourseStudent.count).to eq(1)
    delete "/api/v1/students/courses/#{course.id}", params: student_course_params
    expect(response).to be_successful
    expect(CourseStudent.count).to eq(0)
    expect{CourseStudent.find(student.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
