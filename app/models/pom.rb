# frozen_string_literal: true

class Pom < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :duration,
                        :link
end
