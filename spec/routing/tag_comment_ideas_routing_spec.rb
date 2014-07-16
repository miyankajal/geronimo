require "spec_helper"

describe TagCommentIdeasController do
  describe "routing" do

    it "routes to #index" do
      get("/tag_comment_ideas").should route_to("tag_comment_ideas#index")
    end

    it "routes to #new" do
      get("/tag_comment_ideas/new").should route_to("tag_comment_ideas#new")
    end

    it "routes to #show" do
      get("/tag_comment_ideas/1").should route_to("tag_comment_ideas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tag_comment_ideas/1/edit").should route_to("tag_comment_ideas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tag_comment_ideas").should route_to("tag_comment_ideas#create")
    end

    it "routes to #update" do
      put("/tag_comment_ideas/1").should route_to("tag_comment_ideas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tag_comment_ideas/1").should route_to("tag_comment_ideas#destroy", :id => "1")
    end

  end
end
