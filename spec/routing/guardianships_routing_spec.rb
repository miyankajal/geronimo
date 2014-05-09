require "spec_helper"

describe GuardianshipsController do
  describe "routing" do

    it "routes to #index" do
      get("/guardianships").should route_to("guardianships#index")
    end

    it "routes to #new" do
      get("/guardianships/new").should route_to("guardianships#new")
    end

    it "routes to #show" do
      get("/guardianships/1").should route_to("guardianships#show", :id => "1")
    end

    it "routes to #edit" do
      get("/guardianships/1/edit").should route_to("guardianships#edit", :id => "1")
    end

    it "routes to #create" do
      post("/guardianships").should route_to("guardianships#create")
    end

    it "routes to #update" do
      put("/guardianships/1").should route_to("guardianships#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/guardianships/1").should route_to("guardianships#destroy", :id => "1")
    end

  end
end
