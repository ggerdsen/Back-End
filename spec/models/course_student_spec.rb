# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseStudent do
  describe 'Validations' do
    it { should validate_numericality_of :student_points }
    it { should validate_presence_of :student_points }
  end

  describe 'Relationships' do
    it { should belong_to :course }
    it { should belong_to :student }
  end
end
