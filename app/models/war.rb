class War < ApplicationRecord
  belongs_to :teacher

  validates_presence_of :challenger_course_id,
                        :opponent_course_id,
                        :challenger_course_points,
                        :opponent_course_points,
                        :opponent_course_name

  validates_associated :teacher
end
