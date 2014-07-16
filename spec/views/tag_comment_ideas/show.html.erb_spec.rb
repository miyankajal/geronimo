require 'spec_helper'

describe "tag_comment_ideas/show" do
  before(:each) do
    @tag_comment_idea = assign(:tag_comment_idea, stub_model(TagCommentIdea,
      :tag_id => 1,
      :comment_id => 2,
      :idea_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
