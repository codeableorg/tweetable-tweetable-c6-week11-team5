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

      rescue ActiveRecord::RecordNotFound => error
        render json: {error: error.message }, status: :not_found
      end

      def new
          
      end
    end
  end
  