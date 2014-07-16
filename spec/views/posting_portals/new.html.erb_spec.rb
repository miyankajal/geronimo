require 'spec_helper'

describe "posting_portals/new" do
  before(:each) do
    assign(:posting_portal, stub_model(PostingPortal,
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new posting_portal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posting_portals_path, :method => "post" do
      assert_select "input#posting_portal_description", :name => "posting_portal[description]"
    end
  end
end
