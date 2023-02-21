defmodule DeployDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DeployDemo.Repo,
      # Start the Telemetry supervisor
      DeployDemoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DeployDemo.PubSub},
      # Start the Endpoint (http/https)
      DeployDemoWeb.Endpoint,
      # Start a worker by calling: DeployDemo.Worker.start_link(arg)
      # {DeployDemo.Worker, arg}
      Task.child_spec(fn -> log_task() end)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DeployDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DeployDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp log_task do
    if Mix.env() != :test do
      DeployDemo.Analytics.log_current_startup()
    end
  end
end
