defmodule UserLiveviewWeb.PageController do
  use UserLiveviewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
