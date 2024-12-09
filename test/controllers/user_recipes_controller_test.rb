require "test_helper"

class UserRecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_recipes_create_url
    assert_response :success
  end

  test "should get new" do
    get user_recipes_new_url
    assert_response :success
  end

  test "should get index" do
    get user_recipes_index_url
    assert_response :success
  end

  test "should get destroy" do
    get user_recipes_destroy_url
    assert_response :success
  end
end
