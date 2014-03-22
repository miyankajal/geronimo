require 'spec_helper'

describe "class_sections/show" do
  before(:each) do
    @class_section = assign(:class_section, stub_model(ClassSection,
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
