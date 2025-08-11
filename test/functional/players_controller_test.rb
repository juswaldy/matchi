require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get :index, params: {}
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :new, params: {}
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, params: { player: @player.attributes.except('id', 'created_at', 'updated_at') }
    end

    assert_redirected_to player_path(assigns(:player))
  end

  test "should show player" do
    get :show, params: { id: @player.to_param }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @player.to_param }
    assert_response :success
  end

  test "should update player" do
    patch :update, params: { id: @player.to_param, player: @player.attributes.except('id', 'created_at', 'updated_at') }
    assert_redirected_to player_path(assigns(:player))
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, params: { id: @player.to_param }
    end

    assert_redirected_to players_path
  end
end
