require 'test_helper'

class MiniUrlsControllerTest < ActionController::TestCase
  setup do
    @mini_url = mini_urls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mini_urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mini_url" do
    assert_difference('MiniUrl.count') do
      post :create, :mini_url => @mini_url.attributes
    end

    assert_redirected_to mini_url_path(assigns(:mini_url))
  end

  test "should show mini_url" do
    get :show, :id => @mini_url.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mini_url.to_param
    assert_response :success
  end

  test "should update mini_url" do
    put :update, :id => @mini_url.to_param, :mini_url => @mini_url.attributes
    assert_redirected_to mini_url_path(assigns(:mini_url))
  end

  test "should destroy mini_url" do
    assert_difference('MiniUrl.count', -1) do
      delete :destroy, :id => @mini_url.to_param
    end

    assert_redirected_to mini_urls_path
  end
end
