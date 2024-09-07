# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    token = generate_token(resource) if resource
    render json: {
      message: 'You are logged in.',
      user: {
        id: resource.id,
        email: resource.email,
        username: resource.username
      },
      token: token
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      log_out_success
    else
      log_out_failure
    end
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  end

  def generate_token(user)
    JwtService.encode(user_id: user.id)
  end
end
