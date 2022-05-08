module Api
    class UsersController < ApiController
       # GET api/users
      def index
        @users = User.all
        render json: @users, status: :ok
      end
    
      # GET apì/users/:id
      def show
        @user = User.find(params[:id])
        render json: @user, status: :ok
      end

      # POST api/users
      def create
        @user = User.new(user_params)
    
        if @user.save
          render json: @user, status: :created
        else
            render json: @user.errors , status: :unprocessable_entity
        end
      end

      # DELETE api/users/1
      def destroy
          @user = User.find(params[:id])
          @user.destroy
          render json: {}, status: :no_content
      end


      private
        def user_params
        params.require(:user).permit(:email, :username, :name, :password, :password_confirmation)
        end
    end
  end
  