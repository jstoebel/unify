class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
      can :manage, :all
    elsif user.reg_user?
    end

  end
end
