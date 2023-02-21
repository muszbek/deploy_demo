defmodule DeployDemo.Repo.Migrations.CreateStartEvents do
  use Ecto.Migration

  def change do
    create table(:start_events) do
      add :time, :utc_datetime

      timestamps()
    end
  end
end
