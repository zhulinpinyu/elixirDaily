#
# 徒手撸一个GenServer
#
# iex manual_genserver.ex
# iex(2)> pid = KVStore.start
# #PID<0.114.0>
# iex(3)> KVStore.
# get/2            handle_call/2    init/0           put/3
# start/0
# iex(3)> KVStore.put(pid, "age", 18)
# :ok
# iex(4)> KVStore.get(pid, "age")
# 18


defmodule ServerProcess do
  def start(callback_module) do
    spawn(fn ->
      init_state = callback_module.init()
      loop(callback_module, init_state)
    end)
  end

  def loop(callback_module, current_state) do
    receive do
      {:call, request, caller} ->
        {response, new_state} = callback_module.handle_call(request, current_state)
        send(caller, {:response, response})
        loop(callback_module, new_state)
      {:cast, request} ->
        new_state = callback_module.handle_cast(request, current_state)
        loop(callback_module, new_state)
    end
  end

  def call(server_pid, request) do
    send(server_pid, {:call, request, self()})

    receive do
      {:response, response} -> response
    end
  end

  def cast(server_pid, request), do: send(server_pid, {:cast, request})
end

defmodule KVStore do
  def start do
    ServerProcess.start(__MODULE__)
  end

  def put(pid, k, v) do
    ServerProcess.cast(pid, {:put, k, v})
  end

  def get(pid, k) do
    ServerProcess.call(pid, {:get, k})
  end

  def init do
    %{}
  end

  def handle_cast({:put, k, v}, state), do: Map.put(state, k, v)

  def handle_call({:get, k}, state) do
    {Map.get(state, k), state}
  end
end
