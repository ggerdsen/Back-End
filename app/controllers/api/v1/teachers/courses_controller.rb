# frozen_string_literal: true

module Api
  module V1
    module Teachers
      class CoursesController < ApplicationController

        def update
          require "pry"; binding.pry
          render json: TeacherCourseSerializer.new(Course.update(params[:id], course_params))
          #
        end


        private

        def course_params
        end
      end
    end
  end
end
