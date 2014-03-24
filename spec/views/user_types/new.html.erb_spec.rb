require 'spec_helper'

describe "user_types/new" do
  before(:each) do
    assign(:user_type, stub_model(UserType,
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new user_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_types_path, :method => "post" do
      assert_select "input#user_type_description", :name => "user_type[description]"
    end
  end
end
