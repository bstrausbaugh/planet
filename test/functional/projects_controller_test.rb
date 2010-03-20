require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end
  
  test "hidden projects should not show by default" do
    get :index
    assert_response :success
    projects = assigns(:projects)
    assert_nil projects.find {|p| p.hidden? }
    assert_select "div#filter a", "show all projects"
  end

  test "hidden projects should show if /projects/all url requested" do
    get :all
    assert_response :success
    projects = assigns(:projects)
    assert projects.find {|p| p.hidden? }
    assert_select "div#filter a", "show active projects"
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, :project => { :name => 'Test Project' }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, :id => projects(:registration).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => projects(:registration).to_param
    assert_response :success
  end

  test "should update project" do
    put :update, :id => projects(:registration).to_param, :project => { }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, :id => projects(:registration).to_param
    end

    assert_redirected_to projects_path
  end
end
