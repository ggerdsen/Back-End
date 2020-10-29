# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student do
  describe 'Validations' do
    it { should validate_presence_of :name }
  end

  describe 'OAuth' do
    it "creates or updates itself from an oauth hash" do
      auth = {
        provider: "google",
        uid: "12345678910",
        info: {
          email: "priya@power.com",
          first_name: "Priya",
          last_name: "Power"
        },
        credentials: {
          token: "abcdefg12345",
          refresh_token: "12345abcdefg",
          expires_at: DateTime.now
        }
      }
      Student.update_or_create(auth)
      new_user = Student.first

      expect(new_user.provider).to eq("google")
      expect(new_user.uid).to eq("12345678910")
      expect(new_user.email).to eq("jesse@mountainmantechnologies.com")
      expect(new_user.first_name).to eq("Jesse")
      expect(new_user.last_name).to eq("Spevack")
      expect(new_user.token).to eq("abcdefg12345")
      expect(new_user.refresh_token).to eq("12345abcdefg")
      expect(new_user.oauth_expires_at).to eq(auth[:credentials][:expires_at])

  end
end
