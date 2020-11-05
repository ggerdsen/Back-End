class Api::V1::Teachers::PrizesController < ApplicationController
  def create
    prize = Prize.create!(prize_params)
    render json: PrizeSerializer.new(prize)
  end

  private
  def prize_params
    params.permit(:name, :prize_points, :course_id)
  end
end
