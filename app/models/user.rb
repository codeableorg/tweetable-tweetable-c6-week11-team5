class User < ApplicationRecord
    has_one_attached :avatar

    has_many :tweets, dependent: :nullify
    has_many :likes, dependent: :destroy, inverse_of: "user"
    has_many :liked_tweets, through: :likes, source: :tweet
    enum role: { admin: 0, user: 1 } 
    #bcrypt
    has_secure_password

    # Validations
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}, allow_blank: false
    validates :username, presence: true, uniqueness: true
    validates :avatar, presence: false
    validates :password_digest, presence: true, uniqueness: true
end
