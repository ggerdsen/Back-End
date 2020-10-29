class Teacher < ApplicationRecord
  has_many :courses

  validates_presence_of :name
  devise :omniauthable, omniauth_providers: [:google_oauth2]
end
