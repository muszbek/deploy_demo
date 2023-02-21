defmodule DeployDemoWeb.PageController do
  use DeployDemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
