class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  
  # GET /login
  def new; end


   # POST /sessions => formulario body { email: xxxx, password: xxxx }
  def create
    if auth_hash
      log_in_with_provider
    else
      log_in_with_email
    end
  end

  # DELETE /sessions
  def destroy
    logout
    redirect_to root_path status: :see_other
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end

  def log_in_with_provider
    user = User.find_by(email: auth_hash.info.email)

    user ||= User.create(
      username: auth_hash.info.nickname,
      email: auth_hash.info.email,
      password: SecureRandom.urlsafe_base64
    )

    log_in(user)
    redirect_to root_path
  end

  def log_in_with_email
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      log_in(user)
      redirect_to root_path
    else
      flash.now[:message] = "Invalid credentials"
      render "new", status: :unprocessable_entity
    end
  end

end
