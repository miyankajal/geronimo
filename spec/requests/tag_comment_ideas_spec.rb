require 'spec_helper'

describe "TagCommentIdeas" do
  describe "GET /tag_comment_ideas" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tag_comment_ideas_path
      response.status.should be(200)
    end
  end
end
