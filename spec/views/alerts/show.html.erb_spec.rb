require 'spec_helper'

describe "alerts/show" do
  before(:each) do
    @alert = assign(:alert, stub_model(Alert,
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
