# frozen_string_literal: true

module Api
  module V1
    module Teachers
      class CoursesController < ApplicationController

        def edit
          render json: TeacherCourseSerializer.new(Course.update(params[:id]))
          binding.pry
        end

        def index
          render json: TeacherCourseSerializer.new(Course.all)
        end

        def show
          render json: TeacherCourseSerializer.new(Course.find(params[:id]))
        end
        private

        def course_params
          params.permit(:name, :course_code, :school_name)
        end
      end
    end
  end
end
