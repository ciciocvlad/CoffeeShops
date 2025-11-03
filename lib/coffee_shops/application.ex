defmodule CoffeeShops.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CoffeeShopsWeb.Telemetry,
      CoffeeShops.Repo,
      {DNSCluster, query: Application.get_env(:coffee_shops, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CoffeeShops.PubSub},
      # Start a worker by calling: CoffeeShops.Worker.start_link(arg)
      # {CoffeeShops.Worker, arg},
      # Start to serve requests, typically the last entry
      CoffeeShopsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CoffeeShops.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CoffeeShopsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
