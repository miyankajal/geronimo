require 'spec_helper'

describe "class_sections/index" do
  before(:each) do
    assign(:class_sections, [
      stub_model(ClassSection,
        :description => "Description"
      ),
      stub_model(ClassSection,
        :description => "Description"
      )
    ])
  end

  it "renders a list of class_sections" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
