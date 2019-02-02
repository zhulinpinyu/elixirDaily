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

  def read_request(req, acc \\ %{headers: []}) do
    case :gen_tcp.recv(req, 0) do
      {:ok, {:http_request, :GET, {:abs_path, full_path}, _}} ->
        read_request(req, Map.put(acc, :full_path, full_path))
      {:ok, {:http_header, _, key, _, value}} ->
        read_request(req, Map.put(acc, :headers, [{String.downcase(to_string(key)), value} | acc.headers]))
      {:ok, :http_eoh} ->
        acc
      {:ok, _line} ->
        read_request(req, acc)
    end
  end

  def send_response(socket, response) do
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end

  def child_spec(opts) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, [opts]}}
  end
end
