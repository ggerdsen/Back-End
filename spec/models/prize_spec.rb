# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Prize do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :redeem_points }
  end
  describe 'Relationships' do
    it { should belong_to :course }
  end
end
