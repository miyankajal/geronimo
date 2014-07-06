require 'spec_helper'

describe "posting_portals/edit" do
  before(:each) do
    @posting_portal = assign(:posting_portal, stub_model(PostingPortal,
      :description => "MyString"
    ))
  end

  it "renders the edit posting_portal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posting_portals_path(@posting_portal), :method => "post" do
      assert_select "input#posting_portal_description", :name => "posting_portal[description]"
    end
  end
end
