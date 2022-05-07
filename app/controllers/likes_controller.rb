class LikesController < ApplicationController
    def create;
        @like = Like.new(like_params)
        @like.user = User.all.sample

        if @like.save
            redirect_to(request.referrer || root_path )
        else
            like_to_remove = Like.where(user_id: @like.user_id, tweet_id: @like.tweet_id)
            unless like_to_remove.empty?
                like_to_remove[0].destroy
            end
            redirect_to(request.referrer || root_path )
        end
    end

    private
    def like_params
        params.require(:like).permit(:tweet_id)
    end
end