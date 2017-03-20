defmodule DMWorker.Minion do
  use GenServer
  @moduledoc false

  def start_link(state, opts \\ []) do
    {:ok, pid} = GenServer.start_link(__MODULE__, state, opts)
    IO.inspect("Init minion pid: #{inspect pid}: #{inspect state}, #{inspect opts}")
    {:ok, pid}
  end

  def init(items) do
    IO.inspect("Init items: #{inspect items}")
    {:ok, items}
  end

  def pop do
    GenServer.call(Minion, :pop)
  end

  def push(message) do
    GenServer.cast(Minion, {:push, message})
  end

  def messages do
    GenServer.call(Minion, :messages)
  end

  def handle_call(:pop, from, []) do
   {:reply, nil, []}
  end

  def handle_call(:pop, from, [h | t]) do
    IO.inspect("From : #{inspect from} - state: #{inspect h} | #{inspect t}")
    {:reply, h, t}
  end

  def handle_call(:messages, _from, messages) do
    {:reply, messages, messages}
  end

  def handle_cast({:push, message}, items) do
    {:noreply, [message | items]}
  end
end
