require 'spec_helper'

describe "tag_comment_ideas/edit" do
  before(:each) do
    @tag_comment_idea = assign(:tag_comment_idea, stub_model(TagCommentIdea,
      :tag_id => 1,
      :comment_id => 1,
      :idea_id => 1
    ))
  end

  it "renders the edit tag_comment_idea form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tag_comment_ideas_path(@tag_comment_idea), :method => "post" do
      assert_select "input#tag_comment_idea_tag_id", :name => "tag_comment_idea[tag_id]"
      assert_select "input#tag_comment_idea_comment_id", :name => "tag_comment_idea[comment_id]"
      assert_select "input#tag_comment_idea_idea_id", :name => "tag_comment_idea[idea_id]"
    end
  end
end
