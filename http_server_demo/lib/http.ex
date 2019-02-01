defmodule Http do
  require Logger

  def start_link(port: port, dispatch: dispatch) do
    {:ok, socket} = :gen_tcp.listen(port, active: false, packet: :http_bin, reuseaddr: true)
    Logger.info("在端口#{port}接收连接")

    {:ok, spawn_link(__MODULE__, :accept, [socket, dispatch])}
  end

  def accept(socket, dispatch) do
    {:ok, request} = :gen_tcp.accept(socket)

    spawn(fn ->
      dispatch.(request)
    end)
    accept(socket, dispatch)
  end

  def send_response(socket, response) do
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end

  def child_spec(opts) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, [opts]}}
  end
end
