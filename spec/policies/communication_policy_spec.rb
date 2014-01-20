require "spec_helper"

describe CommunicationPolicy do
  subject { CommunicationPolicy }
  let(:communication) { create :communication }
  let(:admin) { build_stubbed :admin }
  let(:user) { build_stubbed :approved_user }

  permissions :index? do
    it { should permit(admin) }
    it { should permit(user) }
  end

  permissions :show? do
    it { should     permit(admin, communication) }
    it { should_not permit(user, communication) }
  end

  permissions :create? do
    it { should     permit(admin, Communication.new) }
    it { should_not permit(user, Communication.new) }
  end

  permissions :update? do
    it { should     permit(admin, communication) }
    it { should_not permit(user, communication) }
  end

  permissions :destroy? do
    it { should     permit(admin, communication) }
    it { should_not permit(user, communication) }
  end
end
