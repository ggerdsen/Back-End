module Api
  module V1
    module Students
      class CoursesController < ApplicationController

        def create
          cs = CourseStudent.create(student_points: course_params[:student_points], course_id: course_params[:course_id], student_id: course_params[:student_id])
          render json: CourseStudentSerializer.new(cs)
        end

        def index
          #course_students = CourseStudent.where(course_params[:student_id])
          render json: CourseStudentSerializer.new(CourseStudent.where(student_id: course_params[:student_id]))
        end

        private
        def course_params
          params.permit(:student_points, :course_id, :student_id)
        end
      end
    end
  end
end
