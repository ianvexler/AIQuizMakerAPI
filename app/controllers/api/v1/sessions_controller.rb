class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: %i[create signup]

  # initial login, get access & refresh tokens
  def create
    user = User.where(email: authentication_params[:email]).first

    if user.present? && user.valid_password?(authentication_params[:password])
      user.generate_refresh_token

      sign_in(user)

      render json: render_user(user)
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def signup
    user = User.new(signup_params)

    # Temporary for testing
    user.organization = Organization.first

    if user.save
      user.generate_refresh_token

      sign_in(user)

      render json: render_user(user), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # use refresh token to get new access token, rotate refresh token
  def refresh
    return render status: :unauthorized if authentication_params[:rt].nil?

    user = User.find_using_refresh_token(authentication_params[:rt])

    if user.present?
      user.generate_access_and_refresh_tokens

      sign_in(user)

      render status: :ok, json: render_user(user)
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # log out, revoke the access & refresh tokens
  def destroy
    # logic handled by devise jwt warden hooks
    render json: { message: 'Logged out successfully' }, status: :ok
  end

  private

  def authentication_params
    params.require(:user).permit(:email, :password, :rt)
  end

  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def render_user(user)
    { rt: user.rt, user: user.as_json }
  end
end
