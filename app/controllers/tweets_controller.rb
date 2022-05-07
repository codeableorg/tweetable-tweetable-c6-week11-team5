class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]

  # GET /tweets
  def index
    @tweet_new = Tweet.new
    @like_new = Like.new
    @tweets = Tweet.all
    @user_tweets = current_user ? current_user.tweets : []
    @user_likes = current_user ? current_user.liked_tweets : []
  end

  # GET /tweets/1
  def show
    #  @tweet -> Default
    @tweet_new = Tweet.new
    @like_new = Like.new
    @user_tweets = current_user ? current_user.tweets : []
    @user_likes = current_user ? current_user.liked_tweets : []
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  def create
    # binding.pry
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      if params[:tweet][:replied_to_id].empty? # Si no hay un replied hablamos de un tweet
        redirect_to tweets_path, notice: "Tweet was successfully created."
      else
        redirect_to @tweet.replied_to, notice: "Retweet was successfully created"
      end
    else
      if params[:tweet][:replied_to_id].empty? # Si no hay un replied hablamos de un tweet
        redirect_to tweets_path, notice: "Cannot tweet"
      else
        redirect_to @tweet.replied_to, notice: "Cannot retweet"
      end
    end
  end

  # PATCH/PUT /tweets/1
  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: "Tweet was successfully updated."
    else
      redirect_to @tweet, notice: "Tweet cannot be updated."
      # render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1
  def destroy
    @parent_tweet = @tweet.replied_to
    @tweet.destroy
    if @parent_tweet.nil?
      redirect_to tweets_url, notice: "Tweet was successfully destroyed."
    else
      redirect_to @parent_tweet, notice: "Retweet was successfully destroyed."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:body, :replied_to_id)
    end
end
