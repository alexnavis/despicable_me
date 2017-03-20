defmodule DMWorker.Master do
  @moduledoc false
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
      IO.puts("Inside master")
      children = [
        worker(DMWorker.Minion, [[:hello], [name: Minion, function: :start_link]]),
      ]
      supervise(children, strategy: :one_for_one, name: I_AM_MASTER)
  end
end