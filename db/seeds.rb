require 'faker'

Like.destroy_all
Tweet.destroy_all
User.destroy_all


puts "Seeding users"
50.times do
    user = User.new(email: Faker::Internet.email, username: Faker::Internet.username, name: Faker::Name.name, role: :user)
    if user.valid?
        user.save
    else
        p user.errors.full_messages
    end
end

puts "Seeding tweets"
100.times do
    tweet = Tweet.new(user: User.all.sample, body: Faker::Hipster.paragraph_by_chars(characters: 139) )
    if tweet.valid?
        tweet.save
    else
        p tweet.errors.full_messages
    end
end

puts "Seeding retweets"
created_tweets = Tweet.all
200.times do
    retweet = Tweet.new(user: User.all.sample, body: Faker::Hipster.paragraph_by_chars(characters: 139), replied_to: created_tweets.sample )
    if retweet.valid?
        retweet.save
    else
        p retweet.errors.full_messages
    end
end

puts "Seeding likes"
3000.times do
    like = Like.new(user: User.all.sample, tweet: Tweet.all.sample)
    if like.valid?
        like.save
    else
        p like.errors.full_messages
    end
end

puts "Completed"
