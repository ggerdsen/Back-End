# frozen_string_literal: true

module Api
  module V1
    module Teachers
      class CoursesController < ApplicationController
        def index
          teacher = Teacher.find(params[:teacher_id])
          render json: CourseSerializer.new(teacher.courses)
        end

        def show
          course = Course.find(params[:id])
          render json: CourseSerializer.new(course)
        end
        
        def edit
          render json: TeacherCourseSerializer.new(Course.update(params[:id]))
        end

        def create
          render json: CourseSerializer.new(Course.create(course_params))
          ActiveRecord::Base.connection.reset_pk_sequence!(Course)
        end

        def update
          course = Course.find(params[:course_id])
          course.update(course_params)
          render json: CourseSerializer.new(course)
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
