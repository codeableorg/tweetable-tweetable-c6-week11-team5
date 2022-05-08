module Api
    class UsersController < ApiController
      def index
        @users = User.all
        render json: @users, status: :ok
      end
    
      # GET apì/users/:id
      def show
        @user = User.find(params[:id])
        render json: @user, status: :ok
      end

      def create
        @user = User.new(user_params)
    
        if @user.save
          render json: @user, status: :created
        else
            render json: @user.errors.full_messages, status: :unprocessable_entity
        end
      end

      private
        def user_params
        params.require(:user).permit(:email, :username, :name, :password, :password_confirmation)
        end
    end
  end
  