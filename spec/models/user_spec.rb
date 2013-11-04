require 'spec_helper'
require "cancan/matchers"

describe User do
  let(:user) {build_stubbed(:user, email: "test@test.com")}

  it "requires a unique email" do
    existing_user = create(:user, email: "test@test.com")
    User.new(email: "test@test.com").should have(2).error_on(:email)
  end

  it "requires email" do
    User.new.should have(2).error_on(:email)
  end

  it "requires a belonging crpv" do
    User.new.should have(1).error_on(:crpv_id)
  end

  it "should not be approved on creation" do
    user.should_not be_approved
  end

  it "should approve user unless unapproved" do
    user = create(:user)
    user.approve!
    user.should be_approved
  end

  describe "abilities" do
    subject { ability }
    let(:ability) { Ability.new(user) }

    context "for a guest" do
      let(:user) { User.new }

      it { should be_able_to(:show, :pages)}
      it { should be_able_to(:home, :info)}
      it { should be_able_to(:show, :crpvs)}
      it { should be_able_to(:index, :crpvs)}
      it { should be_able_to(:show, :publications)}
      it { should be_able_to(:index, :publications)}
      it { should be_able_to(:new, :messages)}
      it { should be_able_to(:create, :messages)}
    end

    context "for a member" do
      let(:user) {create(:member)}
      let(:dossier) {build(:dossier, crpv: user.crpv)}
      let(:etude) {build(:etude, crpv: user.crpv)}
      let(:publication) {build(:publication, crpv: user.crpv)}

      it { should be_able_to(:intranet, :info)}
      it { should be_able_to(:update, user) }
      it { should be_able_to(:show, :documents) }
      it { should be_able_to(:index, :documents) }
      it { should be_able_to(:show, :enquetes)}
      it { should be_able_to(:index, :enquetes)}
      it { should be_able_to(:create, :dossiers)}
      it { should be_able_to(:create, :etudes)}
      it { should be_able_to(:create, :publications)}
      it { should be_able_to(:index, :dossiers)}
      it { should be_able_to(:index, :etudes)}
      it { should be_able_to(:index, :evenements)}
      [:show, :update].each do |action|
        it { should be_able_to(action, dossier)}
        it { should be_able_to(action, etude)}
        it { should be_able_to(action, publication)}
      end
      it {should_not be_able_to(:destroy, dossier)}
      it {should_not be_able_to(:destroy, etude)}
      it {should_not be_able_to(:destroy, publication)}
    end

    %w(crpv page).each do |resource|
      context "for a #{resource} manager" do
        let(:user) { create(:"#{resource}_manager") }

        [:index, :show, :create, :update].each do |action|
          it { should be_able_to(action, resource.pluralize)}
        end
        it { should be_able_to(:destroy, resource.pluralize) }
        it { should be_able_to(:index, "admin/dashboard")}
      end
    end

    context "for a document manager" do
      let(:user) { create(:"document_manager") }

      [:index, :show, :create, :update].each do |action|
        it { should be_able_to(action, :documents)}
        it { should be_able_to(action, :categories)}
      end
      it { should be_able_to(:destroy, :documents) }
      it { should be_able_to(:destroy, :categories) }
      it { should be_able_to(:index, "admin/dashboard")}
    end

    context "for an etude manager" do
      let(:user) { create(:etude_manager) }

      [:index, :show, :new, :create, :edit, :update, :destroy].each do |action|
        it "should be able to #{action} :etudes" do
          subject.should be_able_to(action, :etudes)
        end
      end
    end

    context "for a publication manager" do
      let(:user) { create(:publication_manager) }

      [:index, :show, :new, :create, :edit, :update, :destroy].each do |action|
        it "should be able to #{action} :publications" do
          subject.should be_able_to(action, :publications)
        end
      end
    end

    context "for a enquete manager" do
      let(:user) { create(:enquete_manager) }

      [:index, :show, :create, :update, :destroy].each do |action|
        it "should be able to #{action} :enquetes" do
          subject.should be_able_to(action, "admin/enquetes")
        end
        it "should be able to #{action} :medicaments" do
          subject.should be_able_to(action, "admin/medicaments")
        end
        it "should be able to #{action} :gravites" do
          subject.should be_able_to(action, "admin/gravites")
        end
        it "should be able to #{action} :evolutions" do
          subject.should be_able_to(action, "admin/evolutions")
        end
      end
    end

    context "for admins" do
      let(:user) { create(:admin) }
      it { should be_able_to(:access, :all) }
    end
  end
end
