defmodule LiveViewStudioWeb.PaginateLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Donations

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")
    paginate_options = %{page: page, per_page: per_page}
    donations = Donations.list_donations(paginate: paginate_options)

    {:noreply,
     assign(socket,
       donations: donations,
       options: paginate_options
     )}
  end

  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    per_page = String.to_integer(per_page)

    socket =
      push_patch(socket,
        to:
          Routes.live_path(
            socket,
            __MODULE__,
            page: socket.assigns.options.page,
            per_page: per_page
          )
      )

    {:noreply, socket}
  end

  defp expires_class(donation) do
    case Donations.almost_expired?(donation) do
      true -> "eat-now"
      false -> "fresh"
    end
  end

  defp page_link(socket, text, page, per_page, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          page: page,
          per_page: per_page
        ),
      class: class
    )
  end
end
