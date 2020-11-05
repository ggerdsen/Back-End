require 'rails_helper'

RSpec.describe 'teachers wars' do
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
      challenger_course_id: challenger.id,
      opponent_course_id: opponent.id,
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
      challenger_course_id: challenger.id,
      opponent_course_id: opponent.id,
      challenger_course_points: course1.course_points,
      opponent_course_points: course2.course_points
    })
    expect(War.count).to eq(1)
    delete "/api/v1/teachers/courses/wars/#{war.id}"
    expect(response).to be_successful
    expect(response).to be_successful
    expect(War.count).to eq(0)
    expect{War.find(war.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
