module Api
  class TweetsController < ApiController
    def index
      @tweets = Tweet.all
      render json: @tweets, status: :ok
    end
  
    # GET apì/tweets/:id
    def show
      @tweet = Tweet.all
      render json: @tweet, status: :ok
    end
  end
end
