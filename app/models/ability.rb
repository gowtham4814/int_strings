class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # Guest user

    can :read, Post
    can :create, Post
    can :all_post, Post
    can :posts, Post
    can :read_post, Post
    can :create, Rating
    can :create, Comment
    can :show, Comment
    can :comment_rating, Comment
    can :edit, Post, user_id: user.id
    can :update, Post, user_id: user.id
    can :destroy, Post, user_id: user.id
    can :edit, Comment, user_id: user.id
    can :update, Comment, user_id: user.id
    can :delete, Comment, user_id: user.id


  end
end