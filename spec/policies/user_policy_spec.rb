require "spec_helper"

describe UserPolicy do
  subject { UserPolicy }
  let(:user) { build_stubbed :approved_user }
  let(:other_user) { build_stubbed :approved_user }
  let(:admin) { build_stubbed :admin }

  permissions :show? do
    it { should permit(user, user) }
    it { should permit(admin, user) }
    it { should_not permit(user, other_user) }
  end

  permissions :index? do
    it { should permit(admin) }
    it { should_not permit(user) }
  end

  permissions :create? do
    it { should_not permit(user, User.new) }
    it { should permit(admin, User.new) }
  end

  permissions :update? do
    it { should permit(user, user) }
    it { should permit(admin, user) }
    it { should_not permit(user, other_user) }
  end

  permissions :destroy? do
    it { should_not permit(user, user) }
    it { should_not permit(user, other_user) }
    it { should     permit(admin, user) }
    it { should_not permit(admin, admin) }
  end
end
