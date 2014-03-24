require 'spec_helper'

describe "teacher_roles/new" do
  before(:each) do
    assign(:teacher_role, stub_model(TeacherRole,
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new teacher_role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teacher_roles_path, :method => "post" do
      assert_select "input#teacher_role_description", :name => "teacher_role[description]"
    end
  end
end
