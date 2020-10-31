module Api
  module V1
    module Teachers
      class CoursesController < ApplicationController

        def update
          render json: CourseSerializer.new(Course.update(params[:id], course_params))
          # 
        end


        private

        def course_params

        end
      end
    end
  end
end
