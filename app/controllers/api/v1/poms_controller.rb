module Api
  module V1
    class PomsController < ApplicationController
      def single_trivia_question
        response = Faraday.get("#{ENV['SINATRA_DOMAIN']}/api/v1/single_trivia_question")
        body = JSON.parse(response.body, symbolize_names: true)
        render json: body
      end
    end
  end
end
