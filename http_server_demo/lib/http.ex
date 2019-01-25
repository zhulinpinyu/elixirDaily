defmodule Http do
  require Logger

  def start_link(port) do
    {:ok, socket} = :gen_tcp.listen(port, active: false, packet: :http_bin, reuseaddr: true)
    Logger.info("在端口#{port}接收连接")

    {:ok, spawn_link(__MODULE__, :accept, [socket])}
  end

  def accept(socket) do
    {:ok, request} = :gen_tcp.accept(socket)

    spawn(fn ->
      body = "Hello World, Current Time: #{Time.to_string(Time.utc_now())}"

      response = """
      HTTP/1.1 200\r
      Content-type: text/html\r
      Content-length: #{byte_size(body)}\r
      \r
      #{body}
      """

      send_response(request, response)
    end)
    accept(socket)
  end

  defp send_response(socket, response) do
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end

  def child_spec(opts) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, [opts]}}
  end
end
