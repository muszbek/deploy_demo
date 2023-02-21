defmodule DeployDemo.Repo do
  use Ecto.Repo,
    otp_app: :deploy_demo,
    adapter: Ecto.Adapters.Postgres
end
