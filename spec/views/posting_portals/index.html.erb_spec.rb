require 'spec_helper'

describe "posting_portals/index" do
  before(:each) do
    assign(:posting_portals, [
      stub_model(PostingPortal,
        :description => "Description"
      ),
      stub_model(PostingPortal,
        :description => "Description"
      )
    ])
  end

  it "renders a list of posting_portals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
