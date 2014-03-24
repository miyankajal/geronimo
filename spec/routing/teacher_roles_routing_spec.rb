require "spec_helper"

describe TeacherRolesController do
  describe "routing" do

    it "routes to #index" do
      get("/teacher_roles").should route_to("teacher_roles#index")
    end

    it "routes to #new" do
      get("/teacher_roles/new").should route_to("teacher_roles#new")
    end

    it "routes to #show" do
      get("/teacher_roles/1").should route_to("teacher_roles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/teacher_roles/1/edit").should route_to("teacher_roles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/teacher_roles").should route_to("teacher_roles#create")
    end

    it "routes to #update" do
      put("/teacher_roles/1").should route_to("teacher_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/teacher_roles/1").should route_to("teacher_roles#destroy", :id => "1")
    end

  end
end
