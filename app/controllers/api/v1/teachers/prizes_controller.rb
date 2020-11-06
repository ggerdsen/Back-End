class Api::V1::Teachers::PrizesController < ApplicationController
  def create
    prize = Prize.create!(prize_params)
    render json: PrizeSerializer.new(prize)
  end

  def index
    teacher = Teacher.find(params[:teacher_id])
    render json: PrizeSerializer.new(teacher.prizes)
  end

  def destroy
    prize = Prize.find(params[:id])
    prize.destroy
    render body: nil, status: :no_content
  end

  private
  def prize_params
    params.permit(:name, :prize_points, :course_id)
  end
end
