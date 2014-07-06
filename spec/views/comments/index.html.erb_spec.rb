require 'spec_helper'

describe "comments/index" do
  before(:each) do
    assign(:comments, [
      stub_model(Comment,
        :comment => "Comment",
        :idea_id => 1,
        :user_id => 2,
        :likes_count => 3,
        :accepted => false
      ),
      stub_model(Comment,
        :comment => "Comment",
        :idea_id => 1,
        :user_id => 2,
        :likes_count => 3,
        :accepted => false
      )
    ])
  end

  it "renders a list of comments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
