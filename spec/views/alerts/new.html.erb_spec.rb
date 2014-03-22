require 'spec_helper'

describe "alerts/new" do
  before(:each) do
    assign(:alert, stub_model(Alert,
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new alert form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => alerts_path, :method => "post" do
      assert_select "input#alert_description", :name => "alert[description]"
    end
  end
end
