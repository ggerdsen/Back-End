module Api
  module V1
    module Students
      class CoursesController < ApplicationController
        def index
          student = Student.find(params[:student_id])
          render json: StudentDashboardSerializer.new(student.courses)
        end

        def create
          cs = CourseStudent.create(student_points: course_params[:student_points], course_id: course_params[:course_id], student_id: course_params[:student_id])
          render json: StudentEnrollmentSerializer.new(cs)
        end

        def destroy
          result = CourseStudent.where('student_id = ? AND course_id = ?', course_params[:student_id], course_params[:course_id])
          result.destroy_all
        end

        private
        def course_params
          params.permit(:student_points, :course_id, :student_id)
        end
      end
    end
  end
end
