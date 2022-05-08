require "rails_helper"

describe "Tweets", type: :request do
  describe "index path" do
    it 'respond with http success status code' do
      get '/api/tweets'
      expect(response).to have_http_status(:ok)
    end

    it "index path returns a json with all tweets" do
      User.create(email: "test123@gmail.com", username: "test123", name: "test123", password: "test123")
      tweets = Tweet.create(body: "Test", user: User.all.first)
      get "/api/tweets"
      tweets = JSON.parse(response.body)
      expect(tweets.size).to eq 1
    end
  end

  describe "show path" do
    it "respond with http success status code" do
      User.create(email: "test123@gmail.com", username: "test123", name: "test123", password: "test123")
      tweet = Tweet.create(body: "Test", user: User.all.first)
      get api_tweet_path(tweet)
      expect(response).to have_http_status(:ok)
    end
  
    # it 'respond with the correct tweet' do
    #   User.create(email: "test123@gmail.com", username: "test123", name: "test123", password: "test123")
    #   tweet = Tweet.create(body: "Test", user: User.all.first)
    #   get api_tweet_path(tweet)
    #   actual_tweet = JSON.parse(response.body)
    #   expect(actual_tweet['id']).to eql(tweet.id)
    # end
  end

end
