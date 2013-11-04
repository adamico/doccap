require "spec_helper"

describe PagesController do
  describe "routing" do
    it "routes /:slug to #show" do
      get("/slug").should route_to("pages#show", :id => "slug")
    end

    it "routes /:parent_id/:id to #show" do
      get("/parent/slug").should route_to("pages#show", :id => "parent/slug")
    end

  end
end
