module Api
  module V1
    class PomsController < ApplicationController

      def single_trivia_question
        response = Faraday.get("http://localhost:3001/api/v1/single_trivia_question")
        binding.pry
        body = JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
