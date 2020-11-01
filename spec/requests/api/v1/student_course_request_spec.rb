
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
    expect(returned_student_course[:data][:id].to_i).to eq(course.id)

    student_course_in_database = CourseStudent.last
    expect(student_course_in_database.course_id).to eq(course.id)
  end
end
