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
    # it { should validate_presence_of :refresh_token }
  end

  describe 'OAuth' do
    it "creates or updates itself from an oauth hash" do
      auth = {
              "access_token"=>
              {
                "credentials"=>
                {
                  "expires"=>"true", "expires_at"=>"1604264187", "token"=>"abcdefg12345"
                },
                "extra"=>
                  {
                    "id_info"=>
                    {
                      "at_hash"=>"7R-wnAsojWP8Mr4_WWRuVg", "aud"=>"810277124767-qu6371arj9e9a42fmurhm7c84cm3b4p0.apps.googleusercontent.com", "azp"=>"810277124767-qu6371arj9e9a42fmurhm7c84cm3b4p0.apps.googleusercontent.com", "email"=>"priya@power.com", "email_verified"=>"true", "exp"=>"1604264188", "family_name"=>"Shakalaka", "given_name"=>"Pry", "iat"=>"1604260588", "iss"=>"https://accounts.google.com", "locale"=>"en", "name"=>"Pry Shakalaka", "picture"=>"https://lh4.googleusercontent.com/-mIqTBC4a5iM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmSp8Uhv89KaXfJMlXzmNgYFkLJmw/s96-c/photo.jpg", "sub"=>"105762916063322960144"
                    },
                "id_token"=>"eyJhbGciOiJSUzI1NiIsImtpZCI6ImQwNWVmMjBjNDUxOTFlZmY2NGIyNWQzODBkNDZmZGU1NWFjMjI5ZDEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI4MTAyNzcxMjQ3NjctcXU2MzcxYXJqOWU5YTQyZm11cmhtN2M4NGNtM2I0cDAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4MTAyNzcxMjQ3NjctcXU2MzcxYXJqOWU5YTQyZm11cmhtN2M4NGNtM2I0cDAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDU3NjI5MTYwNjMzMjI5NjAxNDQiLCJlbWFpbCI6ImNrYy5jYW1lcm9uQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaW",
                "raw_info"=>
                  {
                    "email"=>"priya@power.com", "email_verified"=>"true", "family_name"=>"Shakalaka", "given_name"=>"Pry", "locale"=>"en", "name"=>"Pry Shakalaka", "picture"=>"https://lh4.googleusercontent.com/-mIqTBC4a5iM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmSp8Uhv89KaXfJMlXzmNgYFkLJmw/s96-c/photo.jpg", "sub"=>"105762916063322960144"
                  }
                },
                "info"=>
                  {
                    "email"=>"priya@power.com", "email_verified"=>"true", "first_name"=>"Pry", "image"=>"https://lh4.googleusercontent.com/-mIqTBC4a5iM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmSp8Uhv89KaXfJMlXzmNgYFkLJmw/s96-c/photo.jpg", "last_name"=>"Shakalaka", "name"=>"Pry Shakalaka", "unverified_email"=>"priya@power.com"
                  },
                "provider"=>"google_oauth2", "uid"=>"10545741948856754983"
              },
                "client_id"=>"810277124767-qu6371arj9e93b4p0.apps.googleusercontent.com", "client_secret"=>"1A9jzAl8z", "controller"=>"api/v1/students", "action"=>"create"
              }
      # auth = {
      #   provider: "google",
      #   uid: "12345678910",
      #   email: "priya@power.com",
      #   first_name: "Priya",
      #   last_name: "Power",
      #   token: "abcdefg12345",
      #   refresh_token: "12345abcdefg"
      # }
      Student.update_or_create(auth)
      new_user = Student.last
      expect(new_user.provider).to eq("google_oauth2")
      expect(new_user.uid).to eq("10545741948856754983")
      expect(new_user.email).to eq("priya@power.com")
      expect(new_user.first_name).to eq("Pry")
      expect(new_user.last_name).to eq("Shakalaka")
      expect(new_user.token).to eq("abcdefg12345")
    end
  end
end
