# frozen_string_literal: true

class ApplicationController < ActionController::API
  protect_from_forgery with: :exception

  def current_user
    require "pry"; binding.pry
    @current_user

  end
end
