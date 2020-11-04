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
        # Teacher.create(teacher_params)
        # render json: TeacherSerializer.new(Teacher.last)
        teacher_params = JSON.parse(request.body.read, symbolize_names: true)
        teacher = Teacher.update_or_create(teacher_params)
        render json: TeacherSerializer.new(teacher)
      end

      def update
        # render json: TeacherSerializer.new(Teacher.update(params[:id], teacher_params))
        teacher_params = JSON.parse(request.body.read, symbolize_names: true)
        render json: TeacherSerializer.new(Teacher.update(params[:id], teacher_params))
      end

      def destroy
        Teacher.destroy(params[:id])
        render body: nil, status: :no_content
      end

      def find
        render json: TeacherSerializer.new(Teacher.find_by(uid: params[:uid]))
      end

      private

      def teacher_params
        params.permit(:first_name, :last_name, :provider, :uid, :email, :token, :refresh_token, :school_name, :school_district)
      end
    end
  end
end
