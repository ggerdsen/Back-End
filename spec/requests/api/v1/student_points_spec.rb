require 'rails_helper'

RSpec.describe 'student points' do

  it 'can display points on student course show page' do
    teacher1 = create(:teacher)
    course1 = teacher1.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher1.id,
      course_points: 200
    })
    student = create(:student)
    joins1 = student.course_students.create(course_id: course1.id, student_points: 10)

    joins_params = ({student_id: student.id, course_id: course1.id})
    get "/api/v1/students/courses/points", params: joins_params
    expect(response).to be_successful

    returned_joins = JSON.parse(response.body, symbolize_names: true)

    expect(returned_joins[:data][0][:id].to_i).to eq(joins1.id)
    expect(returned_joins[:data][0][:attributes][:student_points]).to eq(joins1.student_points)
    expect(returned_joins[:data][0][:attributes][:course_id]).to eq(joins1.course_id)
    expect(returned_joins[:data][0][:attributes][:student_id]).to eq(joins1.student_id)
  end

  it 'can display total points on student dashboard (course index)' do
    teacher1 = create(:teacher)
    course1 = teacher1.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher1.id,
      course_points: 2342
    })
    teacher2 = create(:teacher)
    course2 = teacher2.courses.create({
      name: 'Forensic Psychology',
      course_code: '1234abcd',
      school_name: 'Hogwarts High School',
      teacher_id: teacher2.id,
      course_points: 65766
    })
    course3 = teacher2.courses.create({
      name: 'You Shouldnt See Me',
      course_code: '1a2b3c4d',
      school_name: 'Hogwarts High School',
      teacher_id: teacher2.id,
      course_points: 34346
    })
    student = create(:student)
    join1 = student.course_students.create(course_id: course1.id, student_points: 231)
    join2 = student.course_students.create(course_id: course2.id, student_points: 765)
    join3 = student.course_students.create(course_id: course3.id, student_points: 435)

    total_points = join1.student_points + join2.student_points + join3.student_points

    joins_params = ({student_id: student.id})
    get "/api/v1/students/courses/all-points", params: joins_params
    expect(response).to be_successful
    returned_joins = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(returned_joins.count).to eq(3)
    returned_points = returned_joins[0][:attributes][:student_points] + returned_joins[1][:attributes][:student_points] + returned_joins[2][:attributes][:student_points]
    expect(returned_points).to eq(total_points)
  end
end
