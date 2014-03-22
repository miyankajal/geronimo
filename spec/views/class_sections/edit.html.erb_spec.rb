require 'spec_helper'

describe "class_sections/edit" do
  before(:each) do
    @class_section = assign(:class_section, stub_model(ClassSection,
      :description => "MyString"
    ))
  end

  it "renders the edit class_section form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => class_sections_path(@class_section), :method => "post" do
      assert_select "input#class_section_description", :name => "class_section[description]"
    end
  end
end
