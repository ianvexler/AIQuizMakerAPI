class Api::V1::CoursesController < Api::V1::BaseController
  def index
    @courses = current_user.courses.not_archived

    render json: { courses: @courses }, status: :ok
  end
end
