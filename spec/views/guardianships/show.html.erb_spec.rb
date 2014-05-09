require 'spec_helper'

describe "guardianships/show" do
  before(:each) do
    @guardianship = assign(:guardianship, stub_model(Guardianship,
      :user_id => 1,
      :guardian_id => 2,
      :create => "Create",
      :destroy => "Destroy"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Create/)
    rendered.should match(/Destroy/)
  end
end
