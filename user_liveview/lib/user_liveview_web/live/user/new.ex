defmodule UserLiveviewWeb.UserLive.New do
  use Phoenix.LiveView

  alias UserLiveview.Accounts.User
  alias UserLiveview.Accounts
  alias UserLiveviewWeb.UserView
  alias UserLiveviewWeb.UserLive
  alias UserLiveviewWeb.Router.Helpers, as: Routes

  def mount(_, socket) do
    {:ok, assign(socket, %{changeset: Accounts.change_user(%User{})})}
  end

  def render(assigns), do: UserView.render("new.html", assigns)

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      %User{}
      |> Accounts.change_user(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, %{changeset: changeset})}
  end

  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        {:stop, socket |> put_flash(:info, "Created successful") |> redirect(to: Routes.live_path(socket, UserLive.Index))}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
