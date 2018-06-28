defmodule KeyValue do
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

# iex(1)> {:ok, pid} = GenServer.start(KeyValue, %{})
# {:ok, #PID<0.113.0>}
# iex(2)> GenServer.cast(pid, {:put, :foo, "bar"})
# :ok
# iex(3)> GenServer.call(pid, {:get, :foo})
# {:ok, "bar"}
