# frozen_string_literal: true

require 'rails_helper'

describe 'Students API' do
  it 'sends a list of students' do
    students = create_list(:student, 3)

    courses = create_list(:course, 3)

    courses.each do |course|
      create(:course_student, course: course, student: students.first)
    end

    get '/api/v1/students'

    expect(response).to be_successful

    students = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(students).to have_key(:data)
    expect(students[:data]).to be_an(Array)
    expect(students[:data].count).to eq(3)

    student = students[:data][0]

    expect(student).to have_key(:id)
    expect(student[:id]).to be_an(String)

    expect(student).to have_key(:attributes)
    expect(student[:attributes]).to be_a(Hash)

    expect(student[:attributes]).to have_key(:first_name)
    expect(student[:attributes][:first_name]).to be_a(String)

    expect(student[:attributes]).to have_key(:last_name)
    expect(student[:attributes][:last_name]).to be_a(String)

    expect(student[:attributes]).to have_key(:uid)
    expect(student[:attributes][:uid]).to be_a(String)

    expect(student[:attributes]).to have_key(:email)
    expect(student[:attributes][:email]).to be_a(String)

    expect(student[:attributes]).to have_key(:token)
    expect(student[:attributes][:token]).to be_a(String)

    expect(student).to have_key(:relationships)
    expect(student[:relationships]).to be_a(Hash)

    expect(student[:relationships]).to have_key(:courses)
    expect(student[:relationships][:courses]).to be_a(Hash)

    expect(student[:relationships][:courses]).to have_key(:data)
    expect(student[:relationships][:courses][:data]).to be_an(Array)
    expect(student[:relationships][:courses][:data].count).to eq(3)
    expect(student[:relationships][:courses][:data][0]).to have_key(:id)
    expect(student[:relationships][:courses][:data][0]).to have_key(:type)
  end

  it "can find a teacher by uid" do
    student1 = create(:student, uid: "100")
    student2 = create(:student, uid: "101")
    student3 = create(:student, uid: "102")

    get "/api/v1/students/find/#{student1.uid}"

    expect(response).to be_successful
    student = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(student[:attributes][:uid]).to eq(student1.uid)

    expect(student).to have_key(:id)
    expect(student[:id]).to be_an(String)

    expect(student).to have_key(:attributes)
    expect(student[:attributes]).to be_a(Hash)

    expect(student[:attributes]).to have_key(:first_name)
    expect(student[:attributes][:first_name]).to be_a(String)

    expect(student[:attributes]).to have_key(:last_name)
    expect(student[:attributes][:last_name]).to be_a(String)

    expect(student[:attributes]).to have_key(:uid)
    expect(student[:attributes][:uid]).to be_a(String)

    expect(student[:attributes]).to have_key(:email)
    expect(student[:attributes][:email]).to be_a(String)

    expect(student[:attributes]).to have_key(:token)
    expect(student[:attributes][:token]).to be_a(String)

    # expect(student[:attributes]).to have_key(:refresh_token)
    # expect(student[:attributes][:refresh_token]).to be_a(String)
  end

  it 'can get one student by its id' do
    id = create(:student).id

    get "/api/v1/students/#{id}"

    student = JSON.parse(response.body, symbolize_names: true)

    student = student[:data]

    expect(student).to have_key(:id)
    expect(student[:id]).to be_an(String)

    expect(student).to have_key(:attributes)
    expect(student[:attributes]).to be_a(Hash)

    expect(student[:attributes]).to have_key(:first_name)
    expect(student[:attributes][:first_name]).to be_a(String)

    expect(student[:attributes]).to have_key(:last_name)
    expect(student[:attributes][:last_name]).to be_a(String)

    expect(student[:attributes]).to have_key(:uid)
    expect(student[:attributes][:uid]).to be_a(String)

    expect(student[:attributes]).to have_key(:email)
    expect(student[:attributes][:email]).to be_a(String)

    expect(student[:attributes]).to have_key(:token)
    expect(student[:attributes][:token]).to be_a(String)

    expect(student).to have_key(:relationships)
    expect(student[:relationships]).to be_a(Hash)

    expect(student[:relationships]).to have_key(:courses)
    expect(student[:relationships][:courses]).to be_a(Hash)

    expect(student[:relationships][:courses]).to have_key(:data)
    expect(student[:relationships][:courses][:data]).to be_an(Array)
  end

  it 'can create a new student' do

    student_params = { user_data:
      { provider: 'google',
        uid: '12345678910',
        info: {
          first_name: 'Joe',
          last_name: 'Smith',
          email: 'joe@smith.com',
        },
        credentials: {token: 'abcdefg12345'}
      }
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/students', headers: headers, params: JSON.generate(student_params)
    expect(response).to be_successful
    student = Student.last
    expect(student.first_name).to eq(student_params[:user_data][:info][:first_name])

  end

  it 'can update an student' do
    id = create(:student).id
    previous_name = Student.last.first_name
    student_params = { first_name: 'Joe' }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v1/students/#{id}", headers: headers, params: JSON.generate(student_params)
    expect(response).to be_successful
    student = Student.find_by(id: id)
    expect(student.first_name).to_not eq(previous_name)
    expect(student.first_name).to eq('Joe')
  end

  it 'can delete an student' do
    student = create(:student)

    expect(Student.count).to eq(1)

    expect { delete "/api/v1/students/#{student.id}" }.to change(Student, :count).by(-1)

    expect(response).to be_successful
    expect(Student.count).to eq(0)
    expect { Student.find(student.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
