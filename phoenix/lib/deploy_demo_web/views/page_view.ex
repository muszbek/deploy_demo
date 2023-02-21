defmodule DeployDemoWeb.PageView do
  use DeployDemoWeb, :view

  alias DeployDemo.Analytics
  alias DeployDemo.Analytics.Startup

  def time(%Startup{time: time}), do: time
end
