module Api
  module V1
    class PomsController < ApplicationController

      def single_trivia_question
        response = Faraday.get("http://localhost:4567/api/v1/single_trivia_question")
      end
    end
  end
end
