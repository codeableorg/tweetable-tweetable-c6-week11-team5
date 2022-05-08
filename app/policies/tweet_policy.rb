class TweetPolicy < ApplicationPolicy
    
    class Scope
        attr_reader :user, :scope

        def initialize(user, scope)
            @user = user
            @scope = scope
        end

        def resolve
            if user.nil? 
                []
            elsif user.admin?
                scope.all
            else
                scope.where(user: user)
            end
        end
    end

    def update?
        user.admin? or user == record.user
    end

end