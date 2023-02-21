defmodule DeployDemo.Analytics.Startup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "start_events" do
    field :time, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(startup, attrs) do
    startup
    |> cast(attrs, [:time])
    |> validate_required([:time])
  end
end
