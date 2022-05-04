class User < ApplicationRecord
    has_one_attached :avatar
    
    has_many :tweets, dependent: :nullify
    has_many :likes, dependent: :destroy, inverse_of: "user"
    enum role: { admin: 0, user: 1 } 
    
    # Validations
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}, allow_blank: false
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true
    validates :avatar, presence: false
end