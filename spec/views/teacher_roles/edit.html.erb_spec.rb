require 'spec_helper'

describe "teacher_roles/edit" do
  before(:each) do
    @teacher_role = assign(:teacher_role, stub_model(TeacherRole,
      :description => "MyString"
    ))
  end

  it "renders the edit teacher_role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teacher_roles_path(@teacher_role), :method => "post" do
      assert_select "input#teacher_role_description", :name => "teacher_role[description]"
    end
  end
end
