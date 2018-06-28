defmodule KeyValue do
  use GenServer

  # interface

  def start do
    GenServer.start(__MODULE__, %{})
  end

  def put(server, key, value) do
    GenServer.cast(server, {:put, key, value})
  end

  def get(server, key) do
    GenServer.call(server, {:get, key})
  end


  #impl

  def init(state \\%{}) do
    {:ok, state}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.fetch!(state, key), state}
  end
end

# iex(1)> {:ok, pid} = KeyValue.start()
# {:ok, #PID<0.113.0>}
# iex(2)> KeyValue.put(pid, :foo, "bar")
# :ok
# iex(3)> KeyValue.get(pid, :foo)
# {:ok, "bar"}
