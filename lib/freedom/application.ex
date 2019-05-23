defmodule Freedom.Application do

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Freedom.Worker.start_link(arg)
      # {Freedom.Worker, arg}
      {Redix, {System.get_env("REDIS_URL"), [name: :redix]}},
      {Plug.Cowboy, scheme: :http, plug: Freedom.HelloWorldPlug, options: [port: 8080]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Freedom.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
