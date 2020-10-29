require 'rails_helper'

RSpec.describe Pom do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :duration}
    it {should validate_presence_of :link}
  end
end
