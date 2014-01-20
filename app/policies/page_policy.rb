class PagePolicy < ApplicationPolicy
  def index?   ; user.admin?                                 ; end
  def show?    ; scope.where(id: record.id).exists?          ; end
  def create?  ; user.admin?                                 ; end
  def update?  ; user.admin?                                 ; end
  def destroy? ; user.admin?                                 ; end

  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user.admin?
        scope
      else
        scope.published
      end
    end
  end
end
