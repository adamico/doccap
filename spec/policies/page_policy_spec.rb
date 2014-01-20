require "spec_helper"

describe PagePolicy do
  subject { PagePolicy }

  let(:page)  { create :published }
  let(:draft) { create :draft }
  let(:admin) { build_stubbed :admin }
  let(:user)  { build_stubbed :approved_user }

  permissions :index? do
    it { should     permit(admin) }
    it { should_not permit(user) }
  end

  permissions :show? do
    it { should     permit(admin, page) }
    it { should     permit(admin, draft) }
    it { should     permit(nil, page) }
    it { should_not permit(User.new, draft) }
  end

  permissions :create? do
    it { should     permit(admin) }
    it { should_not permit(user) }
  end

  permissions :update? do
    it { should     permit(admin) }
    it { should_not permit(user) }
  end

  permissions :destroy? do
    it { should     permit(admin) }
    it { should_not permit(user) }
  end
end
