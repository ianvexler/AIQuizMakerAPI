
class HealthChecksController < ApplicationController
  def check
    # Check database connection
    if ActiveRecord::Base.connection.active?
      render json: { status: 'ok', message: 'Database connection is healthy' }, status: :ok
    else
      render json: { status: 'error', message: 'Database connection is not healthy' }, status: :service_unavailable
    end
  end
end