class SessionsController < ApplicationController
  # GET /login
  def new; end

  #POST /sessions
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      log_in(user)
      redirect_to root_path
    else
      flash.now[:message]= "Email or password invalid"
      render "new", status: :unprocessable_entity
    end 
  end

  # DELETE /sessions
  def destroy
    logout
    redirect_to root_path status: :see_other
  end
end
