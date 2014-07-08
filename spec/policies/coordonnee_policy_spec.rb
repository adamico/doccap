require "spec_helper"

describe CoordonneePolicy do
  subject { CoordonneePolicy }
  let(:coordonnee) { create :coordonnee }
  let(:admin)      { create :admin }
  let(:user)       { create :approved_user }

  permissions :index? do
    it { should permit(admin) }
    it { should permit(user) }
  end

  permissions :show? do
    it { should     permit(admin, coordonnee) }
    it { should     permit(user, coordonnee) }
  end

  permissions :create? do
    it { should     permit(admin, Coordonnee.new) }
    it { should_not permit(user, Coordonnee.new) }
  end

  permissions :update? do
    it { should     permit(admin, coordonnee) }
    it { should_not permit(user, coordonnee) }
  end

  permissions :destroy? do
    it { should     permit(admin, coordonnee) }
    it { should_not permit(user, coordonnee) }
  end
end
