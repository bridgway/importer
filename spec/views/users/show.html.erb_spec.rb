require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :firstname => "Firstname",
      :lastname => "Lastname",
      :user_type => "User Type",
      :school_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Lastname/)
    expect(rendered).to match(/User Type/)
    expect(rendered).to match(/1/)
  end
end
