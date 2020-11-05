require 'rails_helper'

RSpec.describe 'teachers wars' do
  it 'can find another teachers course by course code' do
    teacher1 = create(:teacher)
    course1 = create(:course, teacher_id: teacher1.id)
    teacher2 = create(:teacher)
    course2 = create(:course, teacher_id: teacher2.id)

    get "/api/v1/teachers/courses/find?coursecode=#{course2.course_code}"
    expect(response).to be_successful
    course = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(course[:attributes][:name]).to_not eq(course1.name)
    expect(course[:attributes][:name]).to eq(course2.name)
  end

  it 'can create a war' do
    challenger = create(:teacher)
    course1 = challenger.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      course_points: 2000
    })

    opponent = create(:teacher)
    course2 = opponent.courses.create({
      name: 'Forensic Psychology',
      course_code: '1234abcd',
      school_name: 'Hogwarts High School',
      course_points: 2500
    })
    war_params = ({
      teacher_id: challenger.id,
      challenger_course_id: course1.id,
      opponent_course_id: course2.id,
      challenger_course_points: course1.course_points,
      opponent_course_points: course2.course_points
    })
    post "/api/v1/teachers/courses/wars", params: war_params
    expect(response).to be_successful
    war = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(war[:attributes][:teacher_id].to_i).to eq(challenger.id)
    expect(war[:attributes][:challenger_course_points]).to eq(course1.course_points)
    expect(war[:attributes][:opponent_course_points]).to eq(course2.course_points)
  end

  it 'can destroy a war' do
    challenger = create(:teacher)
    course1 = challenger.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      course_points: 2000
    })

    opponent = create(:teacher)
    course2 = opponent.courses.create({
      name: 'Forensic Psychology',
      course_code: '1234abcd',
      school_name: 'Hogwarts High School',
      course_points: 2500
    })
    war = challenger.wars.create({
      challenger_course_id: course1.id,
      opponent_course_id: course2.id,
      challenger_course_points: course1.course_points,
      opponent_course_points: course2.course_points,
      opponent_course_name: course2.name
    })
    expect(War.count).to eq(1)
    delete "/api/v1/teachers/courses/wars/#{war.id}"
    expect(response).to be_successful
    expect(War.count).to eq(0)
    expect{War.find(war.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can see all wars associated with a teacher' do
    challenger = create(:teacher)
    course1 = challenger.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      course_points: 2000
    })
    course2 = challenger.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      course_points: 2000
    })

    opponent1 = create(:teacher)
    course3 = opponent1.courses.create({
      name: 'Forensic Psychology',
      course_code: '1234abcd',
      school_name: 'Hogwarts High School',
      course_points: 2500
    })
    opponent2 = create(:teacher)
    course4 = opponent2.courses.create({
      name: 'Forensic Psychology',
      course_code: '1234abcd',
      school_name: 'Hogwarts High School',
      course_points: 2500
    })
    war1 = challenger.wars.create({
      challenger_course_id: course1.id,
      opponent_course_id: course3.id,
      challenger_course_points: course1.course_points,
      opponent_course_points: course3.course_points,
      opponent_course_name: course3.name 
    })
    war2 = challenger.wars.create({
      challenger_course_id: course2.id,
      opponent_course_id: course4.id,
      challenger_course_points: course2.course_points,
      opponent_course_points: course4.course_points,
      opponent_course_name: course4.name
    })
    expect(War.count).to eq(2)
    teacher_wars_params = ({
      teacher_id: challenger.id
      })
    get "/api/v1/teachers/courses/wars", params: teacher_wars_params
    expect(response).to be_successful
    all_wars = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(all_wars.count).to eq(2)
    expect(all_wars[0][:id].to_i).to eq(war1.id)
    expect(all_wars[0][:attributes][:challenger_course_points]).to eq(war1.challenger_course_points)
    expect(all_wars[1][:id].to_i).to eq(war2.id)
    expect(all_wars[1][:attributes][:challenger_course_points]).to eq(war1.challenger_course_points)
  end
end
