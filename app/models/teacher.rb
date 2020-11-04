# frozen_string_literal: true

class Teacher < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :wars, dependent: :destroy

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true
  validates :role, presence: true

  def self.update_or_create(auth)
    teacher = Teacher.find_by(uid: auth[:uid]) || Teacher.new
    teacher.attributes = {
      provider: auth[:provider],
      uid: auth[:uid],
      email: auth[:email],
      first_name: auth[:first_name],
      last_name: auth[:last_name],
      token: auth[:token],
      school_name: auth[:school_name],
      school_district: auth[:school_district],
      role: "teacher"
      }

    teacher.save
    teacher
  end
end
