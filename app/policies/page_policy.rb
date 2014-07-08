class PagePolicy < ApplicationPolicy
  def index?   ; user.admin?                        ; end
  def show?    ; scope.where(id: record.id).exists? ; end
  def create?  ; user && user.admin?                ; end
  def update?  ; user && user.admin?                ; end
  def destroy? ; user && user.admin?                ; end

  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user && user.admin?
        scope
      else
        scope.published
      end
    end
  end
end
