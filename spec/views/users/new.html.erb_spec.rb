require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :username => "MyString",
      :email => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :password_digest => "MyString",
      :remember_token => "MyString",
      :type => 1,
      :enrollment_id => 1,
      :class_id => 1
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_username", :name => "user[username]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_first_name", :name => "user[first_name]"
      assert_select "input#user_last_name", :name => "user[last_name]"
      assert_select "input#user_password_digest", :name => "user[password_digest]"
      assert_select "input#user_remember_token", :name => "user[remember_token]"
      assert_select "input#user_type", :name => "user[type]"
      assert_select "input#user_enrollment_id", :name => "user[enrollment_id]"
      assert_select "input#user_class_id", :name => "user[class_id]"
    end
  end
end
