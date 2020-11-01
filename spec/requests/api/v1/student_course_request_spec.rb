
require 'rails_helper'

RSpec.describe 'student courses' do
  xit 'updates a course' do
    student = create(:teacher)

    course = create(:course, teacher_id: teacher.id)

    patch "/api/v1/teachers/courses/#{course.id}"

    expect(response).to be_successful

    course = JSON.parse(response.body, symbolize_names: true)
    # expect(response).to be_successful
    #
    # expect(students).to have_key(:data)
    # expect(students[:data]).to be_an(Array)
    # expect(students[:data].count).to eq(3)


  end

  it 'creates a new student course' do
    teacher = create(:teacher)
    course = teacher.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher.id
    })
    
    student = Student.create!(name: Faker::Name.name )
    course_params = ({
      teacher_id: teacher.id,
      course_id: course.id,
      student_id: student.id,
      points: 0
    })

    post "/api/v1/students/courses", params: course_params
    
    expect(response).to be_successful

    course = JSON.parse(response.body, symbolize_names: true)
  
  end
end
