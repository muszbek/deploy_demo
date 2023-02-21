defmodule DeployDemoWeb.PageControllerTest do
  use DeployDemoWeb.ConnCase

  test "GET /", %{conn: conn} do
    DeployDemo.AnalyticsFixtures.startup_fixture()
    
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
