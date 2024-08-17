module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      reject_unauthorized_connection unless current_user
    end

    private

    def find_verified_user
      token = request.headers['Authorization']&.split(' ')&.last
      env['warden'].request.headers['Authorization'] = "Bearer #{token}"
      user = env['warden'].authenticate(:jwt)
      user || reject_unauthorized_connection
    end
  end
end
