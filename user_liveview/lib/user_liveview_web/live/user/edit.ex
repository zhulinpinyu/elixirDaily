defmodule UserLiveviewWeb.UserLive.Edit do
  use Phoenix.LiveView

  alias UserLiveview.Accounts
  alias UserLiveviewWeb.UserView
  alias UserLiveviewWeb.UserLive
  alias UserLiveviewWeb.Router.Helpers, as: Routes

  def mount(%{path_params: %{"id" => id}}, socket) do
    user = Accounts.get_user!(id)
    {:ok,
      assign(socket, %{
        user: user,
        changeset: Accounts.change_user(user)
      })
    }
  end

  def render(assigns), do: UserView.render("edit.html", assigns)

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      socket.assigns.user
      |> Accounts.change_user(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.update_user(socket.assigns.user, params) do
      {:ok, user} ->
        {:stop,
         socket
         |> put_flash(:info, "更新成功")
         |> redirect(to: Routes.live_path(socket, UserLive.Show, user))
        }
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
