require 'rails_helper'

RSpec.describe 'Teachers API' do
  it 'sends a list of teachers' do
    teachers = create_list(:teacher, 3)
    get '/api/v1/teachers'

    expect(response).to be_successful
    teachers = JSON.parse(response.body, symbolize_names: true)

    expect(teachers).to have_key(:data)
    expect(teachers[:data]).to be_an(Array)
    expect(teachers[:data].count).to eq(3)

    teacher = teachers[:data][0]

    expect(teacher).to have_key(:id)
    expect(teacher[:id]).to be_an(String)

    expect(teacher).to have_key(:attributes)
    expect(teacher[:attributes]).to be_a(Hash)

    expect(teacher[:attributes]).to have_key(:name)
    expect(teacher[:attributes][:name]).to be_a(String)

    expect(teacher).to have_key(:relationships)
    expect(teacher[:relationships]).to be_a(Hash)

    expect(teacher[:relationships]).to have_key(:courses)
    expect(teacher[:relationships][:courses]).to be_a(Hash)

    expect(teacher[:relationships][:courses]).to have_key(:data)
    expect(teacher[:relationships][:courses][:data]).to be_an(Array)
  end

  it 'can get one teacher by its id' do
    id = create(:teacher).id
    get "/api/v1/teachers/#{id}"

    expect(response).to be_successful
    teacher = JSON.parse(response.body, symbolize_names: true)

    teacher = teacher[:data]

    expect(teacher).to have_key(:id)
    expect(teacher[:id]).to be_an(String)

    expect(teacher).to have_key(:attributes)
    expect(teacher[:attributes]).to be_a(Hash)

    expect(teacher[:attributes]).to have_key(:name)
    expect(teacher[:attributes][:name]).to be_a(String)

    expect(teacher).to have_key(:relationships)
    expect(teacher[:relationships]).to be_a(Hash)

    expect(teacher[:relationships]).to have_key(:courses)
    expect(teacher[:relationships][:courses]).to be_a(Hash)

    expect(teacher[:relationships][:courses]).to have_key(:data)
    expect(teacher[:relationships][:courses][:data]).to be_an(Array)
  end

  it 'can create a new teacher' do
    teacher_params = { name: 'Mr. John Kimble' }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/teachers', headers: headers, params: JSON.generate(teacher_params)
    expect(response).to be_successful

    created_teacher = Teacher.last
    expect(created_teacher.name).to eq(teacher_params[:name])
  end

  it 'can update a teacher' do
    id = create(:teacher).id
    previous_name = Teacher.last.name
    teacher_params = { name: 'Mr. John Kimble' }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v1/teachers/#{id}", headers: headers, params: JSON.generate(teacher_params)
    expect(response).to be_successful

    teacher = Teacher.find_by(id: id)
    expect(teacher.name).to_not eq(previous_name)
    expect(teacher.name).to eq('Mr. John Kimble')
  end

  it 'can delete a teacher' do
    teacher = create(:teacher)
    expect(Teacher.count).to eq(1)

    expect { delete "/api/v1/teachers/#{teacher.id}" }.to change(Teacher, :count).by(-1)
    expect(response).to be_successful

    expect(Teacher.count).to eq(0)
    expect { Teacher.find(teacher.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
