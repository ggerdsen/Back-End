require 'rails_helper'

RSpec.describe War do
  describe 'Validations' do
    it { should validate_presence_of :challenger_course_id }
    it { should validate_presence_of :opponent_course_id }
    it { should validate_presence_of :challenger_course_points }
    it { should validate_presence_of :opponent_course_points }
  end

  describe 'Relationships' do
    it { should belong_to :teacher }
  end
end
