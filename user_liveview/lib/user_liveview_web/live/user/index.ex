defmodule UserLiveviewWeb.UserLive.Index do
  use Phoenix.LiveView

  alias UserLiveview.Accounts
  alias UserLiveviewWeb.UserView

  def mount(_session, socket) do
    {:ok, fetch(socket)}
  end

  def render(assigns) do
    UserView.render("index.html", assigns)
  end

  def fetch(socket) do
    assign(socket, users: Accounts.list_users())
  end
end
