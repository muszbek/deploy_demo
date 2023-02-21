defmodule DeployDemo.AnalyticsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DeployDemo.Analytics` context.
  """

  @doc """
  Generate a startup.
  """
  def startup_fixture(attrs \\ %{}) do
    {:ok, startup} =
      attrs
      |> Enum.into(%{
        time: ~U[2023-02-05 16:45:00Z]
      })
      |> DeployDemo.Analytics.create_startup()

    startup
  end
end
