require 'spec_helper'

describe "comments/new" do
  before(:each) do
    assign(:comment, stub_model(Comment,
      :comment => "MyString",
      :idea_id => 1,
      :user_id => 1,
      :likes_count => 1,
      :accepted => false
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comments_path, :method => "post" do
      assert_select "input#comment_comment", :name => "comment[comment]"
      assert_select "input#comment_idea_id", :name => "comment[idea_id]"
      assert_select "input#comment_user_id", :name => "comment[user_id]"
      assert_select "input#comment_likes_count", :name => "comment[likes_count]"
      assert_select "input#comment_accepted", :name => "comment[accepted]"
    end
  end
end
