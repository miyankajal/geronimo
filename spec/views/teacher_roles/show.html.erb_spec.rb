require 'spec_helper'

describe "teacher_roles/show" do
  before(:each) do
    @teacher_role = assign(:teacher_role, stub_model(TeacherRole,
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
