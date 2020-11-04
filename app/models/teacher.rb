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
  validates :refresh_token, presence: true
  validates :school_name, presence: true
  validates :school_district, presence: true
end
