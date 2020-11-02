module Api
  module V1
    module Students
      class CoursesController < ApplicationController
        def index
          # courses = Course.joins(:course_students).select("courses.*, course_students.*").where("course_students.student_id = #{course_params[:student_id]}")
          course_student_ids = CourseStudent.where(student_id: course_params[:student_id]).pluck(:course_id)
          Course.select("course.*, course_students.student_points").joins(:course_students).where(id: course_student_ids)
          binding.pry
          courses = Course.where(id: course_student_ids)
          render json: CourseSerializer.new(courses)
        end

        def create
          cs = CourseStudent.create(student_points: course_params[:student_points], course_id: course_params[:course_id], student_id: course_params[:student_id])
          render json: CourseStudentSerializer.new(cs)
        end

        private
        def course_params
          params.permit(:student_points, :course_id, :student_id)
        end
      end
    end
  end
end
