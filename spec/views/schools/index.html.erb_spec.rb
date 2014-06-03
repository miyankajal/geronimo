require 'spec_helper'

describe "schools/index" do
  before(:each) do
    assign(:schools, [
      stub_model(School,
        :name => "Name",
        :address => "Address",
        :phone_no => "Phone No"
      ),
      stub_model(School,
        :name => "Name",
        :address => "Address",
        :phone_no => "Phone No"
      )
    ])
  end

  it "renders a list of schools" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Phone No".to_s, :count => 2
  end
end
