defmodule PortsDemo.BasicPort do
  use GenServer

  require Logger

  @command "./bin/long_runing.rb"

  def start_link(args \\[], opts \\[]) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  def init(_) do
    port = Port.open({:spawn, @command}, [:binary, :exit_status])
    Port.monitor(port)
    {:ok, %{port: port, latest_output: nil, exit_status: nil}}
  end

  def handle_info({_port, {:data, text_line}}, state) do
    Logger.info(fn -> "Data: #{inspect text_line}" end)
    {:noreply, %{state | latest_output: String.trim(text_line)}}
  end

  def handle_info({_port, {:exit_status, status}}, state) do
    Logger.info(fn -> "外部任务退出，状态: #{status}" end)
    {:noreply, %{state | exit_status: status}}
  end

  def handle_info({:DOWN, _ref, :port, port, :normal}, state) do
    Logger.info(fn -> "收到结束的信息，来源: #{inspect port}" end)
    {:noreply, state}
  end

  def handle_info(_, state), do: {:noreply, state}
end
