require File.dirname(__FILE__) + '/../test_helper'
require 'comments_controller'

# Re-raise errors caught by the controller.
class CommentsController; def rescue_action(e) raise e end; end

class CommentsControllerTest < Test::Unit::TestCase

  def setup
    @controller = CommentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = login_as 'quentin'
    @post = posts(:one)
  end

  def test_should_create_comment_with_admin_login
    assert_difference('Comment.count') do
      post :create, 
        :post_id => @post,
        :comment => { }
    end
    assert_not_nil assigns(:comment)
    assert_redirected_to post_path(@post)
  end

  def test_should_get_edit_with_admin_login
    get :edit, :id => comments(:one).id, :post_id => @post
    assert_response :success
  end

  def test_should_update_comment_with_admin_login
    put :update, :id => comments(:one).id, :post_id => @post, :comment => { }
    assert_not_nil assigns(:comment)
    assert_redirected_to post_path(@post)
  end

  def test_should_destroy_comment_with_admin_login
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => comments(:one).id, :post_id => @post
    end
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => comments(:three).id, :post_id => @post
    end
    assert_redirected_to post_path(@post)
  end

####

  def test_should_create_comment_with_login
    login_as 'aaron'
    assert_difference('Comment.count') do
      post :create, 
        :post_id => @post,
        :comment => { }
    end
    assert_not_nil assigns(:comment)
    assert_redirected_to post_path(@post)
  end

####

  def test_should_get_edit_with_owner_login
    login_as 'aaron'
    get :edit, :id => comments(:three).id, :post_id => @post
    assert_response :success
  end

  def test_should_update_comment_with_owner_login
    login_as 'aaron'
    put :update, :id => comments(:three).id, :post_id => @post, :comment => { }
    assert_not_nil assigns(:comment)
    assert_redirected_to post_path(@post)
  end

  def test_should_destroy_comment_with_owner_login
    login_as 'aaron'
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => comments(:three).id, :post_id => @post
    end
    assert_redirected_to post_path(@post)
  end

####

  def test_should_NOT_get_edit_with_owner_login
    login_as 'aaron'
    get :edit, :id => comments(:one).id, :post_id => @post
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_update_comment_with_owner_login
    login_as 'aaron'
    put :update, :id => comments(:one).id, :post_id => @post, :comment => { }
    assert_not_nil assigns(:comment)
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

  def test_should_NOT_destroy_comment_with_owner_login
    login_as 'aaron'
    assert_difference('Comment.count', 0) do
      delete :destroy, :id => comments(:one).id, :post_id => @post
    end
    assert_not_nil flash[:error]
    assert_redirected_to root_path
  end

####

  def test_should_NOT_create_comment_without_login
    login_as nil
    assert_difference('Comment.count', 0) do
      post :create, 
        :post_id => @post,
        :comment => { }
    end
    assert_nil assigns(:comment)
    assert_not_nil flash[:error]
    assert_redirected_to login_path
  end

  def test_should_NOT_get_edit_without_login
    login_as nil
    get :edit, :id => comments(:one).id, :post_id => @post
    assert_nil assigns(:comment)
    assert_not_nil flash[:error]
    assert_redirected_to login_path
  end

  def test_should_NOT_update_comment_without_login
    login_as nil
    put :update, :id => comments(:one).id, :post_id => @post, :comment => { }
    assert_nil assigns(:comment)
    assert_not_nil flash[:error]
    assert_redirected_to login_path
  end

  def test_should_NOT_destroy_comment_without_login
    login_as nil
    assert_difference('Comment.count', 0) do
      delete :destroy, :id => comments(:three).id, :post_id => @post
    end
    assert_not_nil flash[:error]
    assert_redirected_to login_path
  end

end
