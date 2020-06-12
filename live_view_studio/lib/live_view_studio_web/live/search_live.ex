defmodule LiveViewStudioWeb.SearchLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Stores

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        zip: "",
        stores: Stores.list_stores(),
        loading: false
      )

    {:ok, socket}
  end

  def handle_event("query", %{"zip" => zip}, socket) do
    send(self(), {:run_query_zip, zip})
    socket = assign(socket, zip: zip, stores: [], loading: true)
    {:noreply, socket}
  end

  def handle_info({:run_query_zip, zip}, socket) do
    socket =
      case Stores.find_by_zip(zip) do
        [] ->
          socket
          |> assign(stores: [], loading: false)
          |> put_flash(:info, "zip 找不到相应的店 \"#{zip}\"")

        stores ->
          assign(socket, stores: stores, loading: false)
      end

    {:noreply, socket}
  end

  def render(assigns) do
    ~L"""
    <div id="search">
      <h1>Find a Store</h1>
      <form phx-submit="query">
        <input type="text" name="zip" value="<%= @zip %>" autofocus autocomplete="off" <%= if @loading, do: "readonly" %>>
        <button type="submit">
          <img src="images/search.svg" />
        </button>
      </form>

      <%= if @loading do %>
        <div class="loader">Loading</div>
      <% end %>

      <div class="stores">
        <ul>
          <%= for store <- @stores do %>
          <li>
            <div class="first-line">
              <div class="name">
                <%= store.name %>
              </div>
              <div class="status">
                <%= if store.open do %>
                  <span class="open">Open</span>
                <% else %>
                  <span class="close">Close</span>
                <% end %>
              </div>
            </div>
            <div class="second-line">
              <div class="street">
                <img src="images/location.svg"/>
                <%= store.street %>
              </div>
              <div class="phone_number">
                <img src="images/location.svg"/>
                <%= store.phone_number %>
              </div>
            </div>
          </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end
end
