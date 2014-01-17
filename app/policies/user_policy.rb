class UserPolicy < ApplicationPolicy
  def show?    ; user.admin? or record == user  ; end
  def index?   ; user.admin?                    ; end
  def create?  ; user.admin?                    ; end
  def update?  ; user.admin? or record == user  ; end
  def destroy? ; user.admin? and record != user ; end
end
