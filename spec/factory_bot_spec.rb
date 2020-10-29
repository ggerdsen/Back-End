require 'rails_helper'

RSpec.describe 'FactoryBot' do
  it 'creates a student' do
    create_list(:student, 3)

    expect(Student.all.count).to eq(3)
    Student.all.each do |student|
      expect(student.name).to be_a(String)
    end
  end
end