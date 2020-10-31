# frozen_string_literal: true

class Teacher < ApplicationRecord
  has_many :courses

  validates_presence_of :name
    def self.update_or_create(auth)
      teacher = Teacher.find_by(uid: auth[:uid]) || Teacher.new
      teacher.attributes = {
        provider: auth[:provider],
        uid: auth[:uid],
        email: auth[:email],
        first_name: auth[:first_name],
        last_name: auth[:last_name],
        token: auth[:token],
        refresh_token: auth[:refresh_token]
        }

      teacher.save

      teacher
    end
end
