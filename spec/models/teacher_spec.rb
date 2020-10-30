# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher do
  describe 'Validations' do
    it { should validate_presence_of :name }
  end
end
