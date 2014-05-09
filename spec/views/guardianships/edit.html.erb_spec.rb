require 'spec_helper'

describe "guardianships/edit" do
  before(:each) do
    @guardianship = assign(:guardianship, stub_model(Guardianship,
      :user_id => 1,
      :guardian_id => 1,
      :create => "MyString",
      :destroy => "MyString"
    ))
  end

  it "renders the edit guardianship form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guardianships_path(@guardianship), :method => "post" do
      assert_select "input#guardianship_user_id", :name => "guardianship[user_id]"
      assert_select "input#guardianship_guardian_id", :name => "guardianship[guardian_id]"
      assert_select "input#guardianship_create", :name => "guardianship[create]"
      assert_select "input#guardianship_destroy", :name => "guardianship[destroy]"
    end
  end
end
