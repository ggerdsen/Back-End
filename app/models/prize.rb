# frozen_string_literal: true

class Prize < ApplicationRecord
  belongs_to :course
  validates_presence_of :name
  validates_presence_of :prize_points


end
