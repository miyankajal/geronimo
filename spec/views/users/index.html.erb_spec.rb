require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :username => "Username",
        :email => "Email",
        :first_name => "First Name",
        :last_name => "Last Name",
        :password_digest => "Password Digest",
        :remember_token => "Remember Token",
        :type => 1,
        :enrollment_id => 2,
        :class_id => 3
      ),
      stub_model(User,
        :username => "Username",
        :email => "Email",
        :first_name => "First Name",
        :last_name => "Last Name",
        :password_digest => "Password Digest",
        :remember_token => "Remember Token",
        :type => 1,
        :enrollment_id => 2,
        :class_id => 3
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Password Digest".to_s, :count => 2
    assert_select "tr>td", :text => "Remember Token".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
