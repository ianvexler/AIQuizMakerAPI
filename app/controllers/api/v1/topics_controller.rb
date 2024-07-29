class Api::V1::TopicsController < Api::V1::BaseController
  before_action :set_course, only: [:index]

  def index
    @topics = @course.topics

    render json: { topics: @topics }, status: :ok
  end

  private

  def set_course
    @course = Course.find_by(id: params[:course_id])
    return if @course

    render json: { error: 'Course not found' }, status: :not_found
  end
end
