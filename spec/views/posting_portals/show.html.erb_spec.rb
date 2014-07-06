require 'spec_helper'

describe "posting_portals/show" do
  before(:each) do
    @posting_portal = assign(:posting_portal, stub_model(PostingPortal,
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
