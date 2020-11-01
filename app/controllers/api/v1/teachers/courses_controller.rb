# frozen_string_literal: true

module Api
  module V1
    module Teachers
      class CoursesController < ApplicationController
        def create
          
          render json: TeacherCourseSerializer.new(Course.create(course_params))
          course = Course.last
          # course.generate_course_code
        end

        def update
          render json: TeacherCourseSerializer.new(Course.update(course_params))
        end

        def index
          render json: TeacherCourseSerializer.new(Course.all)
        end

        def show
          render json: TeacherCourseSerializer.new(Course.find(params[:id]))
        end

        private
        def course_params
          params.permit(:name, :course_code, :school_name, :teacher_id)
        end
      end
    end
  end
end
