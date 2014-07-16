require "spec_helper"

describe PostingPortalsController do
  describe "routing" do

    it "routes to #index" do
      get("/posting_portals").should route_to("posting_portals#index")
    end

    it "routes to #new" do
      get("/posting_portals/new").should route_to("posting_portals#new")
    end

    it "routes to #show" do
      get("/posting_portals/1").should route_to("posting_portals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/posting_portals/1/edit").should route_to("posting_portals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/posting_portals").should route_to("posting_portals#create")
    end

    it "routes to #update" do
      put("/posting_portals/1").should route_to("posting_portals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/posting_portals/1").should route_to("posting_portals#destroy", :id => "1")
    end

  end
end
