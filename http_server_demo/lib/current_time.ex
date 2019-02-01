defmodule CurrentTime do
  import Plug.Conn

  def init(option), do: option

  def call(conn, _params) do
    body = "Hello World, Current Time: #{Time.to_string(Time.utc_now())}"
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, body)
  end
end
