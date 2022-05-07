require 'faker'

general_config = {
    many: { users: 50,  tweets: 100, retweets: 200, likes: 3000 },
    medium: { users: 20,  tweets: 40, retweets: 100, likes: 1500 },
    few: { users: 5,  tweets: 10, retweets: 30, likes: 100 },
    none: {users: 0, tweets: 0, retweets: 0, likes: 0 }
}

current_config = :few

Like.destroy_all
Tweet.destroy_all
User.destroy_all

puts "Seeding with -#{ current_config.to_s }- configuration... (Change at seeds.rb) "
puts "Seeding #{general_config[current_config][:users]} users"
general_config[current_config][:users].times do
    user = User.new(email: Faker::Internet.email, username: Faker::Internet.username, name: Faker::Name.name, role: :user)
    if user.valid?
        user.save
    else
        p user.errors.full_messages
    end
end

puts "Seeding #{general_config[current_config][:tweets]} tweets"
general_config[current_config][:tweets].times do
    tweet = Tweet.new(user: User.all.sample, body: Faker::Hipster.paragraph_by_chars(characters: 139) )
    if tweet.valid?
        tweet.save
    else
        p tweet.errors.full_messages
    end
end

puts "Seeding #{general_config[current_config][:retweets]} retweets"
created_tweets = Tweet.all
general_config[current_config][:retweets].times do
    retweet = Tweet.new(user: User.all.sample, body: Faker::Hipster.paragraph_by_chars(characters: 139), replied_to: created_tweets.sample )
    if retweet.valid?
        retweet.save
    else
        p retweet.errors.full_messages
    end
end

puts "Seeding #{general_config[current_config][:likes]} likes"
general_config[current_config][:likes].times do
    like = Like.new(user: User.all.sample, tweet: Tweet.all.sample)
    if like.valid?
        like.save
    else
        p like.errors.full_messages
    end
end

puts "Completed"
