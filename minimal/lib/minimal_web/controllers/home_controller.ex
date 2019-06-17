defmodule MinimalWeb.HomeController do
  use Phoenix.Controller, namespace: MinimalWeb

  def index(conn, _) do
    Phoenix.Controller.html(conn, """
      <h2>Hello Coco!</h2>
    """)
  end
end
