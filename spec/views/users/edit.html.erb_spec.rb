require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :firstname => "MyString",
      :lastname => "MyString",
      :user_type => "MyString",
      :school_id => 1
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_firstname[name=?]", "user[firstname]"

      assert_select "input#user_lastname[name=?]", "user[lastname]"

      assert_select "input#user_user_type[name=?]", "user[user_type]"

      assert_select "input#user_school_id[name=?]", "user[school_id]"
    end
  end
end
