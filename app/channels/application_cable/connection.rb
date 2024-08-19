module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      reject_unauthorized_connection unless current_user
    end

    private

    def find_verified_user
      token = request.params[:token]
      decode_jwt_token(token)
    end

    def decode_jwt_token(token)
      return nil unless token

      begin
        decoded_token = JWT.decode(token, ENV.fetch('DEVISE_SECRET_KEY'), true, { algorithm: 'HS256' })
        user_id = decoded_token[0]['sub']
        User.find_by(id: user_id)
      rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError => e
        Rails.logger.error "JWT Error: #{e.message}"
        nil
      end
    end
  end
end
