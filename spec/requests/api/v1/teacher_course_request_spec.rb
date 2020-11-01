# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teachers courses' do
  it 'updates a course' do
    teacher = create(:teacher)

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

  it 'creates a new course' do
    teacher = create(:teacher)
    course_params = ({
      name: 'Principals of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher.id
    })

    post "/api/v1/teachers/courses", params: course_params
    expect(response).to be_successful

    course = JSON.parse(response.body, symbolize_names: true)
    
  
  end
end
