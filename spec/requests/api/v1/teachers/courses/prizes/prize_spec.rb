require 'rails_helper'

RSpec.describe 'Teacher Course Prize' do
  it 'creates a new prize' do
    teacher = create(:teacher)
    course = teacher.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher.id,
      course_points: 0
        })

    prize_params = {
      name: "Apple Watch",
      prize_points: 10000,
      course_id: course.id
    }

    post "/api/v1/teachers/courses/prizes", params: prize_params

    expect(response).to be_successful
    returned_prize = JSON.parse(response.body, symbolize_names: true)
    expect(returned_prize[:data][:attributes][:name]).to eq(prize_params[:name])
    expect(returned_prize[:data][:attributes][:prize_points]).to eq(prize_params[:prize_points])
    expect(returned_prize[:data][:relationships][:course][:data][:id].to_i).to eq(prize_params[:course_id])

    prize_in_database = Prize.last
    expect(prize_in_database.course_id.to_i).to eq(course.id)
  end
end
