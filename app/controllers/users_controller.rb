class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create edit]
  after_action :verify_authorized, only: %i[update]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @like_new = Like.new
    @user = User.find(params[:id])
    @user_tweets = policy_scope( Tweet )
    @user_likes = current_user ? current_user.liked_tweets : []
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /profile
  def edit
    if params.has_key?(:id)
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to @user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: "User was successfully destroyed."
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :username, :name, :password, :password_confirmation, :avatar)
    end
end
