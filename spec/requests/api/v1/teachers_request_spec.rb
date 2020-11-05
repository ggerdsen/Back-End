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

    expect(teacher[:attributes]).to have_key(:first_name)
    expect(teacher[:attributes][:first_name]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:last_name)
    expect(teacher[:attributes][:last_name]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:uid)
    expect(teacher[:attributes][:uid]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:email)
    expect(teacher[:attributes][:email]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:token)
    expect(teacher[:attributes][:token]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:school_name)
    expect(teacher[:attributes][:school_name]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:school_district)
    expect(teacher[:attributes][:school_district]).to be_a(String)

    expect(teacher).to have_key(:relationships)
    expect(teacher[:relationships]).to be_a(Hash)

    expect(teacher[:relationships]).to have_key(:courses)
    expect(teacher[:relationships][:courses]).to be_a(Hash)

    expect(teacher[:relationships][:courses]).to have_key(:data)
    expect(teacher[:relationships][:courses][:data]).to be_an(Array)
  end

  it "can find a teacher by uid" do
    teacher1 = create(:teacher, uid: "100")
    teacher2 = create(:teacher, uid: "101")
    teacher3 = create(:teacher, uid: "102")

    get "/api/v1/teachers/find/#{teacher1.uid}"

    expect(response).to be_successful
    teacher = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(teacher[:attributes][:uid]).to eq(teacher1.uid)

    expect(teacher).to have_key(:id)
    expect(teacher[:id]).to be_an(String)

    expect(teacher).to have_key(:attributes)
    expect(teacher[:attributes]).to be_a(Hash)

    expect(teacher[:attributes]).to have_key(:first_name)
    expect(teacher[:attributes][:first_name]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:last_name)
    expect(teacher[:attributes][:last_name]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:uid)
    expect(teacher[:attributes][:uid]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:email)
    expect(teacher[:attributes][:email]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:token)
    expect(teacher[:attributes][:token]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:school_name)
    expect(teacher[:attributes][:school_name]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:school_district)
    expect(teacher[:attributes][:school_district]).to be_a(String)
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

    expect(teacher[:attributes]).to have_key(:first_name)
    expect(teacher[:attributes][:first_name]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:last_name)
    expect(teacher[:attributes][:last_name]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:uid)
    expect(teacher[:attributes][:uid]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:email)
    expect(teacher[:attributes][:email]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:token)
    expect(teacher[:attributes][:token]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:school_name)
    expect(teacher[:attributes][:school_name]).to be_a(String)

    expect(teacher[:attributes]).to have_key(:school_district)
    expect(teacher[:attributes][:school_district]).to be_a(String)

    expect(teacher).to have_key(:relationships)
    expect(teacher[:relationships]).to be_a(Hash)

    expect(teacher[:relationships]).to have_key(:courses)
    expect(teacher[:relationships][:courses]).to be_a(Hash)

    expect(teacher[:relationships][:courses]).to have_key(:data)
    expect(teacher[:relationships][:courses][:data]).to be_an(Array)
  end

  it 'can create a new teacher' do
    teacher_params = {
                      :client_id=>"810277124767",
                      :client_secret=>"c5olVAj",
                      :user_data=>
                      {
                        :provider=>"google_oauth2",
                        :uid=>"105",
                        :info=>
                        {
                          :name=>"Alex Zander",
                          :email=>"gio@email.com",
                          :unverified_email=>"gio@email.com",
                          :email_verified=>true,
                          :first_name=>"Alex",
                          :last_name=>"Zander",
                          :image=>"https://lh4.googleusercontent.com/-mIqTBC4a5iM/photo.jpg"
                        },
                        :credentials=>
                          {
                            :token=>"ya29.A0AfH6SMB2OLff",
                            :expires_at=>1604435737,
                            :expires=>true
                          }
                        }
                      }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/teachers', headers: headers, params: JSON.generate(teacher_params)

    expect(response).to be_successful

    created_teacher = Teacher.last

    expect(created_teacher.first_name).to eq(teacher_params[:user_data][:info][:first_name])
    expect(created_teacher.last_name).to eq(teacher_params[:user_data][:info][:last_name])
    expect(created_teacher.provider).to eq(teacher_params[:user_data][:provider])
    expect(created_teacher.uid).to eq(teacher_params[:user_data][:uid])
    expect(created_teacher.email).to eq(teacher_params[:user_data][:info][:email])
    expect(created_teacher.token).to eq(teacher_params[:user_data][:credentials][:token])
  end

  it 'can update a teacher' do
    id = create(:teacher).id
    previous_name = Teacher.last.first_name
    teacher_params = { first_name: 'Mr. John Kimble' }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v1/teachers/#{id}", headers: headers, params: JSON.generate(teacher_params)
    expect(response).to be_successful

    teacher = Teacher.find_by(id: id)
    expect(teacher.first_name).to_not eq(previous_name)
    expect(teacher.first_name).to eq('Mr. John Kimble')
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
