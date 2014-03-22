require "spec_helper"

describe ClassSectionsController do
  describe "routing" do

    it "routes to #index" do
      get("/class_sections").should route_to("class_sections#index")
    end

    it "routes to #new" do
      get("/class_sections/new").should route_to("class_sections#new")
    end

    it "routes to #show" do
      get("/class_sections/1").should route_to("class_sections#show", :id => "1")
    end

    it "routes to #edit" do
      get("/class_sections/1/edit").should route_to("class_sections#edit", :id => "1")
    end

    it "routes to #create" do
      post("/class_sections").should route_to("class_sections#create")
    end

    it "routes to #update" do
      put("/class_sections/1").should route_to("class_sections#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/class_sections/1").should route_to("class_sections#destroy", :id => "1")
    end

  end
end
