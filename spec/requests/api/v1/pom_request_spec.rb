require 'rails_helper'

describe 'Pom Api' do

  it 'sends one trivia question' do
    json_response = File.read('spec/fixtures/trivia_question.json')
    # stub_request(:get, "http://localhost:3001/api/v1/pom/single_trivia_question").to_return(status: 200, body: json_response)
    stub_request(:get, "http://localhost:3001/api/v1/single_trivia_question").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.1.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    get '/api/v1/pom/single_trivia_question'
    expect(response.status).to eq(200)


    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body).to have_key(:response_code)
    expect(body[:response_code]).to eq(0)
    expect(body).to have_key(:results)
    expect(body[:results]).to be_an(Array)
    expect(body[:results].first).to be_a(Hash)
    expect(body[:results].first).to have_key(:category)
    expect(body[:results].first[:category]).to be_a(String)
    expect(body[:results].first).to have_key(:type)
    expect(body[:results].first[:type]).to be_a(String)
    expect(body[:results].first).to have_key(:difficulty)
    expect(body[:results].first[:difficulty]).to be_a(String)
    expect(body[:results].first).to have_key(:question)
    expect(body[:results].first[:question]).to be_a(String)
    expect(body[:results].first).to have_key(:correct_answer)
    expect(body[:results].first[:correct_answer]).to be_a(String)
    expect(body[:results].first).to have_key(:incorrect_answers)
    expect(body[:results].first[:incorrect_answers]).to be_an(Array)
  end
end