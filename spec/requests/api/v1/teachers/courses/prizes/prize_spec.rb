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

  it "can show all prizes on index" do
    teacher = create(:teacher)
    course1 = teacher.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher.id,
      course_points: 0
        })
    course2 = teacher.courses.create({
            name: 'State of Our Union',
            course_code: 'abcd1234',
            school_name: 'These Streets High School',
            teacher_id: teacher.id,
            course_points: 0})

    prize1 = course1.prizes.create!(name: "Apple Watch", prize_points: 10000, course_id: course1.id)

    prize2 = course1.prizes.create!(name: "Raisens", prize_points: 10000, course_id: course1.id)

    prize3 = course2.prizes.create!(name: "Bananas", prize_points: 10000, course_id: course2.id)

    get "/api/v1/teachers/courses/all-prizes", params: {
      teacher_id: teacher.id
    }

    expect(response).to be_successful
    returned_prizes = JSON.parse(response.body, symbolize_names: true)[:data]

    returned_prize1 = returned_prizes[0]
    expect(returned_prize1[:attributes][:name]).to eq(prize1.name)
    expect(returned_prize1[:attributes][:prize_points]).to eq(prize1.prize_points)

    returned_prize2 = returned_prizes[1]
    expect(returned_prize2[:attributes][:name]).to eq(prize2.name)
    expect(returned_prize2[:attributes][:prize_points]).to eq(prize2.prize_points)

    returned_prize3 = returned_prizes[2]
    expect(returned_prize3[:attributes][:name]).to eq(prize3.name)
    expect(returned_prize3[:attributes][:prize_points]).to eq(prize3.prize_points)
  end

  it "can delete prize" do
    teacher = create(:teacher)
    course = teacher.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher.id,
      course_points: 0
        })

    prize1 = course.prizes.create!(name: "Apple Watch", prize_points: 10000, course_id: course.id)

    prize_params = {
      id: prize1.id
    }

    expect(Prize.count).to eq(1)
    delete "/api/v1/teachers/courses/prizes", params: prize_params
    expect(Prize.count).to eq(0)

    expect(response).to be_successful

    expect{Prize.find(prize1.id)}.to raise_error(ActiveRecord::RecordNotFound)

  end
end
