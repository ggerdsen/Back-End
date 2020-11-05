module Api
  module V1
    module Students
      class CoursesController < ApplicationController
        def index
          student = Student.find(params[:student_id])
          render json: CourseSerializer.new(student.courses)
        end

        def show
          course = Course.find(params[:id])
          render json: CourseSerializer.new(course)
        end

        def create
          join_record = CourseStudent.create(student_points: course_params[:student_points], course_id: course_params[:course_id], student_id: course_params[:student_id])
          render json: CourseStudentSerializer.new(join_record)
        end

        def destroy
          result = CourseStudent.where('student_id = ? AND course_id = ?', course_params[:student_id], course_params[:course_id])
          result.destroy_all
        end

        def points
          result = CourseStudent.where('student_id = ? AND course_id = ?', joins_params[:student_id], joins_params[:course_id])
          render json: CourseStudentSerializer.new(result)
        end

        private
        def course_params
          params.permit(:student_points, :course_id, :student_id)
        end

        def joins_params
          params.permit(:student_id, :course_id)
        end
      end
    end
  end
end
