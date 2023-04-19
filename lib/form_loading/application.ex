defmodule FormLoading.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FormLoadingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FormLoading.PubSub},
      # Start Finch
      {Finch, name: FormLoading.Finch},
      # Start the Endpoint (http/https)
      FormLoadingWeb.Endpoint
      # Start a worker by calling: FormLoading.Worker.start_link(arg)
      # {FormLoading.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FormLoading.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FormLoadingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
