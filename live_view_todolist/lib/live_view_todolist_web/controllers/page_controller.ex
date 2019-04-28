defmodule LiveViewTodolistWeb.PageController do
  use LiveViewTodolistWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
