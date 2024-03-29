require "rails_helper"

describe "Users", type: :request do
  describe "index path" do
    it 'respond with http success status code' do
        get '/api/users'
        expect(response).to have_http_status(:ok)
    end

    it "returns a json with all tweets" do
      User.create(email: "test123@gmail.com", username: "test123", name: "test123", password: "test123")
      get "/api/users"
      users = JSON.parse(response.body)
      expect(users.size).to eq 1
    end
  end

  describe "show path" do
    it "respond with http success status code" do
      user = User.create(email: "test123@gmail.com", username: "test123", name: "test123", password: "test123")
      get api_user_path(user)
      expect(response).to have_http_status(:ok)
    end
  
    it 'respond with the correct genre' do
      user = User.create(email: "test123@gmail.com", username: "test123", name: "test123", password: "test123")
      get api_user_path(user)
      actual_user = JSON.parse(response.body)
      expect(actual_user['id']).to eql(user.id)
      expect(actual_user['name']).to eql(user.name)
      expect(actual_user['username']).to eql(user.username)
    end

    it "respond with error when user not found" do
      get "/api/users/1000"
      expect(response).to have_http_status(:not_found)
    end
    
  end

  describe "create path" do
    it "respond with user created" do
     post "/api/users" , params: { user: { email: "test@gmail.com", 
                                        name:"test123",
                                        username:"test123", 
                                        password:"qwerty", password_confirmation:"qwerty" } 
                                      }
      expect(response).to have_http_status(:created)
    end

    it "respond with error when username or email already been takens" do
      User.create(email: "test@gmail.com", username: "test123", name: "test123", password: "qwerty")
      
      post "/api/users" , params: { user: { email: "test@gmail.com", 
                                         name:"test123",
                                         username:"test123", 
                                         password:"qwerty", 
                                         password_confirmation:"qwerty"} 
                                       }

        error = JSON.parse(response.body)
        p error["username"]
        p error["email"]

        expect(response).to have_http_status(:unprocessable_entity)
        expect(error["username"]).to include("has already been taken")
        expect(error["email"]).to include("has already been taken")
     end
  end

  # describe "destroy path" do
  #   it "respond with user was destroyed" do
  #     @user = User.find(params[:id])
  #     @user.destroy
  #     delete api_user_path(@user)
  #     expect(response).to have_http_status(:no_content)
  #   end
  # end
end