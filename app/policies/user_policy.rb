class UserPolicy < ApplicationPolicy
    def index?
        true
    end
  
    def show?
      user.admin? || record == user
    end
  end