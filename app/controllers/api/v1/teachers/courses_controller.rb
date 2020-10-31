# frozen_string_literal: true

module Api
  module V1
    module Teachers
      class CoursesController < ApplicationController

        def update
          render json: TeacherCourseSerializer.new(Course.update(params[:id], course_params))
          #
        end


        private

        def course_params
          params.permit(:name, :course_code, :school_name)
        end
      end
    end
  end
end
