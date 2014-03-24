require 'spec_helper'

describe "user_types/show" do
  before(:each) do
    @user_type = assign(:user_type, stub_model(UserType,
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
