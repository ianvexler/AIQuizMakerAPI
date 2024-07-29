module Api
  module V1
    class BaseController < ActionController::API
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordNotFound do |_ex|
        render json: { error: 'Record not found' }, status: :not_found
      end

      private

      def authenticate_user!
        request.env['warden'].authenticate(:jwt)
        render json: { error: 'unauthorized' }, status: :unauthorized if current_user.nil?
      end
    end
  end
end
