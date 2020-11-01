# frozen_string_literal: true

module Api
  module V1
    class StudentsController < ApplicationController
      def index
        render json: StudentSerializer.new(Student.all)
      end

      def find
        render json: StudentSerializer.new(Student.find_by(uid: params[:uid]))
      end

      def show
        render json: StudentSerializer.new(Student.find(params[:id]))
      end

      def create
        Student.update_or_create(student_params)
        render json: StudentSerializer.new(Student.last)
      end

      def update
        render json: StudentSerializer.new(Student.update(params[:id], student_params))
      end

      def destroy
        Student.destroy(params[:id])
        render body: nil, status: :no_content
      end

      private

      def student_params
        params.permit(:first_name, :last_name, :provider, :uid, :email, :token, :refresh_token)
      end
    end
  end
end
