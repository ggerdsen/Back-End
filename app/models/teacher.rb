# frozen_string_literal: true

class Teacher < ApplicationRecord
  has_many :courses, dependent: :destroy

  validates_presence_of :name
end
