require File.dirname(__FILE__) + '/../test_helper'
require 'messages_controller'

# Re-raise errors caught by the controller.
class MessagesController; def rescue_action(e) raise e end; end

class MessagesControllerTest < Test::Unit::TestCase

  def setup
    @controller = MessagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_new_with_login
    login_as 'aaron'
    get :new
    assert_response :success
  end

  def test_should_not_get_new_without_login
    login_as nil
    get :new
    assert_redirected_to login_path
  end

  def test_should_create_message_with_login
    login_as 'aaron'
    post :create, :subject => "test subject", :body => "test body"
    assert_redirected_to root_path
  end

  def test_should_not_create_message_without_login
    login_as nil
    post :create, :subject => "test subject", :body => "test body"
    assert_redirected_to login_path
  end

end
