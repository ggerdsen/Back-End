require 'rails_helper'

RSpec.describe 'student points' do

  it 'can display points on dashboard(#course index)' do
    teacher1 = create(:teacher)
    course1 = teacher1.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher1.id,
      course_points: 200
    })
    teacher2 = create(:teacher)
    course2 = teacher2.courses.create({
      name: 'Forensic Psychology',
      course_code: '1234abcd',
      school_name: 'Hogwarts High School',
      teacher_id: teacher2.id,
      course_points: 100
    })

    student = create(:student)

    joins1 = student.course_students.create(course_id: course1.id, student_points: 10)

    joins_params = ({student_id: student.id, course_id: course1.id})
    get "/api/v1/students/total-points", params: joins_params
    expect(response).to be_successful

    returned_joins = JSON.parse(response.body, symbolize_names: true)

    expect(returned_joins[:data][0][:id].to_i).to eq(joins1.id)
    expect(returned_joins[:data][0][:attributes][:student_points]).to eq(joins1.student_points)
  end
end
