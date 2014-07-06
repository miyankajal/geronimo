require 'spec_helper'

describe "ideas/edit" do
  before(:each) do
    @idea = assign(:idea, stub_model(Idea,
      :idea => "MyString",
      :user_id => 1,
      :moderator_id => 1,
      :likes_count => 1,
      :tag_id => 1,
      :portal_id => 1,
      :accepted => false
    ))
  end

  it "renders the edit idea form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ideas_path(@idea), :method => "post" do
      assert_select "input#idea_idea", :name => "idea[idea]"
      assert_select "input#idea_user_id", :name => "idea[user_id]"
      assert_select "input#idea_moderator_id", :name => "idea[moderator_id]"
      assert_select "input#idea_likes_count", :name => "idea[likes_count]"
      assert_select "input#idea_tag_id", :name => "idea[tag_id]"
      assert_select "input#idea_portal_id", :name => "idea[portal_id]"
      assert_select "input#idea_accepted", :name => "idea[accepted]"
    end
  end
end
