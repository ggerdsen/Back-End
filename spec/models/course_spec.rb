# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :school_name }
    it { should validate_presence_of :course_points}
  end

  describe 'Relationships' do
    it { should belong_to :teacher }
  end
end
