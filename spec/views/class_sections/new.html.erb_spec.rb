require 'spec_helper'

describe "class_sections/new" do
  before(:each) do
    assign(:class_section, stub_model(ClassSection,
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new class_section form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => class_sections_path, :method => "post" do
      assert_select "input#class_section_description", :name => "class_section[description]"
    end
  end
end
