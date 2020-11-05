# frozen_string_literal: true

module Api
  module V1
    class StudentsController < ApplicationController
      def index
        render json: StudentSerializer.new(Student.all)
      end

      def show
        render json: StudentSerializer.new(Student.find(params[:id]))
      end

      def create
        # student_params
        creation_params = JSON.parse(request.body.read, symbolize_names: true)
        student = Student.update_or_create(creation_params.to_h)
        render json: StudentSerializer.new(student)
      end

      def update
        student_params = JSON.parse(request.body.read, symbolize_names: true)
        render json: StudentSerializer.new(Student.update(params[:id], student_params))
      end

      def destroy
        Student.destroy(params[:id])
        render body: nil, status: :no_content
      end

      def find
        render json: StudentSerializer.new(Student.find_by(uid: params[:uid]))
      end

      private

      def student_params
        require "pry"; binding.pry
        params.permit(:first_name, :last_name, :provider, :uid, :email, :token, :refresh_token)
      end
    end
  end
end
