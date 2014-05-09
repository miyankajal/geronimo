require 'spec_helper'

describe "guardianships/index" do
  before(:each) do
    assign(:guardianships, [
      stub_model(Guardianship,
        :user_id => 1,
        :guardian_id => 2,
        :create => "Create",
        :destroy => "Destroy"
      ),
      stub_model(Guardianship,
        :user_id => 1,
        :guardian_id => 2,
        :create => "Create",
        :destroy => "Destroy"
      )
    ])
  end

  it "renders a list of guardianships" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Create".to_s, :count => 2
    assert_select "tr>td", :text => "Destroy".to_s, :count => 2
  end
end
