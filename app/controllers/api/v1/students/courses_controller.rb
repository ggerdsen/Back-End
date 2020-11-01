module Api
  module V1
    module Students
      class CoursesController < ApplicationController
        
        def create
          render json: CourseStudentSerializer.new(CourseStudent.create(points: course_params[:points], course_id: course_params[:course_id], student_id: course_params[:student_id]))
        end

        private
        def course_params
          params.permit(:points, :course_id, :student_id)
        end
      end
    end
  end
end
