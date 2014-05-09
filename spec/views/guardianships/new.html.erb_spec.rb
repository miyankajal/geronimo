require 'spec_helper'

describe "guardianships/new" do
  before(:each) do
    assign(:guardianship, stub_model(Guardianship,
      :user_id => 1,
      :guardian_id => 1,
      :create => "MyString",
      :destroy => "MyString"
    ).as_new_record)
  end

  it "renders new guardianship form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guardianships_path, :method => "post" do
      assert_select "input#guardianship_user_id", :name => "guardianship[user_id]"
      assert_select "input#guardianship_guardian_id", :name => "guardianship[guardian_id]"
      assert_select "input#guardianship_create", :name => "guardianship[create]"
      assert_select "input#guardianship_destroy", :name => "guardianship[destroy]"
    end
  end
end
