class Ability
  include CanCan::Ability

  def initialize user
    can :read, [Product, ProductDetail, Comment, Rate]
    can :create, User
    return unless user&.active_for_authentication?

    if user.admin?
      can :manage, :all
      return
    end

    can %i(create read), Order, user_id: user.id
    can :manage, Order, user_id: user.id, status: :pending
    can :manage, User, id: user.id
    can :manage, [Comment, Rate], user_id: user.id
  end
end
