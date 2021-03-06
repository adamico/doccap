class CoordonneePolicy < ApplicationPolicy
  def index?   ; user                                        ; end
  def show?    ; user and scope.where(id: record.id).exists? ; end
  def create?  ; user && user.admin?                         ; end
  def update?  ; user && user.admin?                         ; end
  def destroy? ; user && user.admin?                         ; end

  self::Scope = Struct.new(:user, :scope) do
    def resolve
      scope
    end
  end
end
