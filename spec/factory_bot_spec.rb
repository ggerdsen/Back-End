# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FactoryBot' do
  it 'creates a student' do
    create_list(:student, 3)

    expect(Student.all.count).to eq(3)
    Student.all.each do |student|
      expect(student.name).to be_a(String)
      expect(student.id).to be_an(Integer)
    end
  end

  it 'creates a teacher' do
    create_list(:teacher, 3)

    expect(Teacher.all.count).to eq(3)
    Teacher.all.each do |teacher|
      expect(teacher.name).to be_a(String)
      expect(teacher.id).to be_an(Integer)
    end
  end

  it 'creates a course' do
    create_list(:course, 3)

    expect(Course.all.count).to eq(3)
    Course.all.each do |course|
      expect(course.name).to be_a(String)
      expect(course.course_code).to be_an(String)
      expect(course.school_name).to be_a(String)
      expect(course.teacher_id).to be_an(Integer)
      expect(course.id).to be_an(Integer)
    end
  end

  it 'creates a course_student' do
    create_list(:course_student, 3)

    expect(CourseStudent.all.count).to eq(3)
    CourseStudent.all.each do |course_student|
      expect(course_student.student_points).to be_an(Integer)
      expect(course_student.id).to be_an(Integer)
    end
  end
end
