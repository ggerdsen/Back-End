# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student do
  describe 'Validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :provider }
    it { should validate_presence_of :uid }
    it { should validate_uniqueness_of :uid }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :token }
    it { should validate_presence_of :refresh_token }
  end

  describe 'OAuth' do
    it "creates or updates itself from an oauth hash" do
      auth = {
        provider: "google",
        uid: "12345678910",
        email: "priya@power.com",
        first_name: "Priya",
        last_name: "Power",
        token: "abcdefg12345",
        refresh_token: "12345abcdefg"
      }

      Student.update_or_create(auth)
      new_user = Student.last
      expect(new_user.provider).to eq("google")
      expect(new_user.uid).to eq("12345678910")
      expect(new_user.email).to eq("priya@power.com")
      expect(new_user.first_name).to eq("Priya")
      expect(new_user.last_name).to eq("Power")
      expect(new_user.token).to eq("abcdefg12345")
      expect(new_user.refresh_token).to eq("12345abcdefg")
    end
  end
end
