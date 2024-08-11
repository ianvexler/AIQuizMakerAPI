class Api::V1::CoursesController < Api::V1::BaseController
  def index
    @courses = current_user.courses.not_archived

    render json: { courses: @courses }, status: :ok
  end

  def show
    @course = Course.find(params[:id])

    render json: @course, status: :ok
  end
end
