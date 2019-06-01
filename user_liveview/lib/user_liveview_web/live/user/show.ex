defmodule UserLiveviewWeb.UserLive.Show do
  use Phoenix.LiveView

  alias UserLiveviewWeb.UserLive
  alias UserLiveview.Accounts
  alias UserLiveviewWeb.UserView
  def mount(%{path_params: %{"id" => id}}, socket) do
    {:ok, assign(socket, user: Accounts.get_user!(id))}
  end

  def render(assigns) do
    UserView.render("show.html", assigns)
  end

end
