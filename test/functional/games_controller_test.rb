require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index, params: {}
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new, params: {}
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, params: { game: @game.attributes.except('id', 'created_at', 'updated_at') }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, params: { id: @game.to_param }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @game.to_param }
    assert_response :success
  end

  test "should update game" do
    patch :update, params: { id: @game.to_param, game: @game.attributes.except('id', 'created_at', 'updated_at') }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, params: { id: @game.to_param }
    end

    assert_redirected_to games_path
  end
end
