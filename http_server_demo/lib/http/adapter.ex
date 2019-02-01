defmodule Http.Adapter do

  def child_spec(plug: plug, port: port) do
    Http.child_spec(port: port, dispatch: &dispatch(&1, plug))
  end

  def dispatch(req, plug) do
    %Plug.Conn{
      adapter: {__MODULE__, req},
      owner: self()
    }
    |> plug.call([])
  end

  def send_resp(socket, status, headers, body) do
    response = """
      HTTP/1.1 #{status}\r
      #{headers(headers)}\r
      Content-length: #{byte_size(body)}\r
      \r
      #{body}
      """

    Http.send_response(socket, response)
    {:ok, nil, socket}
  end

  defp headers(headers) do
    Enum.reduce(headers, "", fn {key, value}, acc ->
      acc <> key <> ": " <> value <> "\n\r"
    end)
  end
end
