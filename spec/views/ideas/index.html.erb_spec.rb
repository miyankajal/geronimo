require 'spec_helper'

describe "ideas/index" do
  before(:each) do
    assign(:ideas, [
      stub_model(Idea,
        :idea => "Idea",
        :user_id => 1,
        :moderator_id => 2,
        :likes_count => 3,
        :tag_id => 4,
        :portal_id => 5,
        :accepted => false
      ),
      stub_model(Idea,
        :idea => "Idea",
        :user_id => 1,
        :moderator_id => 2,
        :likes_count => 3,
        :tag_id => 4,
        :portal_id => 5,
        :accepted => false
      )
    ])
  end

  it "renders a list of ideas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Idea".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
