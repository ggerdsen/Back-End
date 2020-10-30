module Api
  module V1
    class TeachersController < ApplicationController
      def index
        render json: TeacherSerializer.new(Teacher.all)
      end

      def show
        render json: TeacherSerializer.new(Teacher.find(params[:id]))
      end

      def create
        Teacher.create(teacher_params)
        render json: TeacherSerializer.new(Teacher.last)
      end

      def update
        render json: TeacherSerializer.new(Teacher.update(params[:id], teacher_params))
      end

      def destroy
        Teacher.destroy(params[:id])
        render body: nil, status: :no_content
      end

      private

      def teacher_params
        params.permit(:name)
      end
    end
  end
end
