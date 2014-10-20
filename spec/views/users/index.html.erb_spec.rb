require 'rails_helper'

RSpec.describe "users/index", :type => :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :user_type => "User Type",
        :school_id => 1
      ),
      User.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :user_type => "User Type",
        :school_id => 1
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    assert_select "tr>td", :text => "User Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
