defmodule DMWorker.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
#  import Supervisor.Spec
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [supervisor(DMWorker.Master, [])]
    opts = [strategy: :one_for_one, name: DMWorker.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
