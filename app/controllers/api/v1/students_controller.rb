class Api::V1::StudentsController < ApplicationController

  def index
    render json: StudentSerializer.new(Student.all)
  end

  def show
    render json: StudentSerializer.new(Student.find(params[:id]))
  end

  def create
    Student.create(student_params)
    render json: StudentSerializer.new(Student.last)
  end

  def update
    render json: StudentSerializer.new(Student.update(params[:id], student_params))
  end

  def destroy
    Student.destroy(params[:id])
    render body: nil, status: :no_content
  end

  private

  def student_params
    params.permit(:name)
  end
end
