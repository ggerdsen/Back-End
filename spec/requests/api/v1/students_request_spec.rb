require 'rails_helper'

describe "Students API" do
  it "sends a list of students" do
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

    expect(student[:attributes]).to have_key(:name)
    expect(student[:attributes][:name]).to be_a(String)

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

  it "can get one student by its id" do
    id = create(:student).id

    get "/api/v1/students/#{id}"

    student = JSON.parse(response.body, symbolize_names: true)

    student = student[:data]

    expect(student).to have_key(:id)
    expect(student[:id]).to be_an(String)

    expect(student).to have_key(:attributes)
    expect(student[:attributes]).to be_a(Hash)

    expect(student[:attributes]).to have_key(:name)
    expect(student[:attributes][:name]).to be_a(String)

    expect(student).to have_key(:relationships)
    expect(student[:relationships]).to be_a(Hash)

    expect(student[:relationships]).to have_key(:courses)
    expect(student[:relationships][:courses]).to be_a(Hash)

    expect(student[:relationships][:courses]).to have_key(:data)
    expect(student[:relationships][:courses][:data]).to be_an(Array)
  end

  it "can create a new student" do
    student_id = create(:student).id
    student_params = ({  name: 'Joe' })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/students", headers: headers, params: JSON.generate(student_params)

    created_student = Student.last

    expect(response).to be_successful
    expect(created_student.name).to eq(student_params[:name])
  end

  it "can update an student" do
    id = create(:student).id
    previous_name = Student.last.name
    student_params = { name: "Joe" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/students/#{id}", headers: headers, params: JSON.generate(student_params)
    student = Student.find_by(id: id)

    expect(response).to be_successful
    expect(student.name).to_not eq(previous_name)
    expect(student.name).to eq("Joe")
  end

  it "can delete an student" do
    student = create(:student)

    expect(Student.count).to eq(1)

    expect{ delete "/api/v1/students/#{student.id}" }.to change(Student, :count).by(-1)

    expect(response).to be_successful
    expect(Student.count).to eq(0)
    expect{Student.find(student.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
