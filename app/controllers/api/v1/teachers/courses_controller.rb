# frozen_string_literal: true

module Api
  module V1
    module Teachers
      class CoursesController < ApplicationController
        def index
          teacher = Teacher.find(params[:teacher_id])
          render json: TeacherCourseSerializer.new(teacher.courses)
        end

        def create
          render json: TeacherCourseSerializer.new(Course.create(course_params))
          ActiveRecord::Base.connection.reset_pk_sequence!(Course)
        end

        def update
          course = Course.find(params[:course_id])
          course.update(course_params)
          render json: TeacherCourseSerializer.new(course)
        end

        def show
          render json: TeacherCourseSerializer.new(Course.find(params[:id]))
        end

        def destroy
          Course.destroy(params[:id])
        end

        private
        def course_params
          params.permit(:name, :course_code, :school_name, :teacher_id)
        end
      end
    end
  end
end
