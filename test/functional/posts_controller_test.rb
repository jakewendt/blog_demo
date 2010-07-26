require File.dirname(__FILE__) + '/../test_helper'
require 'posts_controller'

# Re-raise errors caught by the controller.
class PostsController; def rescue_action(e) raise e end; end

class PostsControllerTest < Test::Unit::TestCase

  def setup
    @controller = PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = login_as 'quentin'
  end

  def test_should_get_index_without_login
    login_as nil
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  def test_should_show_post_without_login
    login_as nil
    get :show, :id => posts(:one).id
    assert_not_nil assigns(:post)
    assert_response :success
  end

###

  def test_should_get_new_with_admin_login
    get :new
    assert_response :success
  end

  def test_should_create_post_with_admin_login
    assert_difference('Post.count') do
      post :create, :post => { }
    end
    assert_not_nil flash[:notice]
    assert_redirected_to post_path(assigns(:post))
  end

  def test_should_get_edit_with_admin_login
    get :edit, :id => posts(:one).id
    assert_response :success
  end

  def test_should_update_post_with_admin_login
    put :update, :id => posts(:one).id, :post => { }
    assert_not_nil flash[:notice]
    assert_redirected_to post_path(assigns(:post))
  end

  def test_should_destroy_post_with_admin_login
    assert_difference('Post.count', -1) do
      delete :destroy, :id => posts(:one).id
    end
    assert_redirected_to posts_path
  end

###

  def test_should_NOT_get_new_without_admin_login
    login_as 'aaron'
    get :new
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_create_post_without_admin_login
    login_as 'aaron'
    assert_difference('Post.count',0) do
      post :create, :post => { }
    end
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_get_edit_without_admin_login
    login_as 'aaron'
    get :edit, :id => posts(:one).id
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_update_post_without_admin_login
    login_as 'aaron'
    put :update, :id => posts(:one).id, :post => { }
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_destroy_post_without_admin_login
    login_as 'aaron'
    assert_difference('Post.count', 0) do
      delete :destroy, :id => posts(:one).id
    end
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

###

  def test_should_NOT_get_new_without_login
    login_as 'aaron'
    get :new
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_create_post_without_login
    login_as 'aaron'
    assert_difference('Post.count',0) do
      post :create, :post => { }
    end
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_get_edit_without_login
    login_as 'aaron'
    get :edit, :id => posts(:one).id
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_update_post_without_login
    login_as 'aaron'
    put :update, :id => posts(:one).id, :post => { }
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_destroy_post_without_login
    login_as 'aaron'
    assert_difference('Post.count', 0) do
      delete :destroy, :id => posts(:one).id
    end
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

end
