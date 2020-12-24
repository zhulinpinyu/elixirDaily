defmodule LiveViewStudioWeb.PaginateLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Donations

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")
    sort_by = String.to_atom(params["sort_by"] || "id")
    sort_order = String.to_atom(params["sort_order"] || "asc")
    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}
    donations = Donations.list_donations(paginate: paginate_options, sort: sort_options)

    {:noreply,
     assign(socket,
       donations: donations,
       options: Map.merge(paginate_options, sort_options)
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

  defp sort_link(socket, text, sort_by, opts) do
    text =
      if sort_by == opts.sort_by do
        text <> emoji(opts.sort_order)
      else
        text
      end

    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          sort_by: sort_by,
          sort_order: toggle_sort_order(opts.sort_order),
          page: opts.page,
          per_page: opts.per_page
        )
    )
  end

  defp toggle_sort_order(:asc), do: :desc
  defp toggle_sort_order(:desc), do: :asc

  defp emoji(:asc), do: "👇"
  defp emoji(:desc), do: "👆"
end
