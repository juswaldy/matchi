require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  setup do
    @team = teams(:one)
  end

  test "should get index" do
    get :index, params: {}
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "should get new" do
    get :new, params: {}
    assert_response :success
  end

  test "should create team" do
    assert_difference('Team.count') do
      post :create, params: { team: { name: 'AnotherTeam', score: @team.score } }
    end

    assert_redirected_to team_path(assigns(:team))
  end

  test "should show team" do
    get :show, params: { id: @team.to_param }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @team.to_param }
    assert_response :success
  end

  test "should update team" do
    patch :update, params: { id: @team.to_param, team: { name: 'UpdatedName', score: @team.score } }
    assert_redirected_to team_path(assigns(:team))
  end

  test "should destroy team" do
    assert_difference('Team.count', -1) do
      delete :destroy, params: { id: @team.to_param }
    end

    assert_redirected_to teams_path
  end
end
