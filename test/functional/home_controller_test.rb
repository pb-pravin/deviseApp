require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "devise shouldnt call to_key on model class" do

    user = User.new
    user.org_id = 'org_id'
    user.term_id = 'org_id'
    user.id = 'username'
    user.password = 'password'

    sign_in user
  end
end
