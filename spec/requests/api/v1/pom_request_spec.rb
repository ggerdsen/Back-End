require 'rails_helper'

describe 'Pom Api' do

  it 'sends one trivia question' do

    get '/api/v1/pom/single_trivia_question'
    require "pry"; binding.pry
    expect(last_response.status).to eq(200)

  end

end
