require 'spec_helper'

describe "ideas/show" do
  before(:each) do
    @idea = assign(:idea, stub_model(Idea,
      :idea => "Idea",
      :user_id => 1,
      :moderator_id => 2,
      :likes_count => 3,
      :tag_id => 4,
      :portal_id => 5,
      :accepted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Idea/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/false/)
  end
end
