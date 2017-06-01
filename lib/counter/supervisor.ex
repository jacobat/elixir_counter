defmodule Counter.Supervisor do
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Task, [Counter.Srv, :accept, [4040]])
    ]

    opts = [strategy: :one_for_one, name: Counter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
