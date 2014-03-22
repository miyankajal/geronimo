require 'spec_helper'

describe "points/edit" do
  before(:each) do
    @point = assign(:point, stub_model(Point,
      :description => "MyString",
      :value => "",
      :credit => false
    ))
  end

  it "renders the edit point form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => points_path(@point), :method => "post" do
      assert_select "input#point_description", :name => "point[description]"
      assert_select "input#point_value", :name => "point[value]"
      assert_select "input#point_credit", :name => "point[credit]"
    end
  end
end
