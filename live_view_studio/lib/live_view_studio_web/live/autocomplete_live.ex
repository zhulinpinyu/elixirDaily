defmodule LiveViewStudioWeb.AutocompleteLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Stores
  alias LiveViewStudio.Cities

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        zip: "",
        city: "",
        stores: [],
        matches: [],
        loading: false
      )

    {:ok, socket}
  end

  def handle_event("zip-query", %{"zip" => zip}, socket) do
    send(self(), {:run_query_zip, zip})
    socket = assign(socket, zip: zip, stores: [], loading: true)
    {:noreply, socket}
  end

  def handle_event("city-query", %{"city" => city}, socket) do
    send(self(), {:run_query_city, city})
    socket = assign(socket, city: city, stores: [], loading: true)
    {:noreply, socket}
  end

  def handle_event("city-suggest", %{"city" => prefix}, socket) do
    socket = assign(socket, matches: Cities.suggest(prefix))
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

  def handle_info({:run_query_city, city}, socket) do
    socket =
      case Stores.find_by_city(city) do
        [] ->
          socket
          |> assign(stores: [], loading: false)
          |> put_flash(:info, "city 找不到相应的店 \"#{city}\"")

        stores ->
          assign(socket, stores: stores, loading: false)
      end

    {:noreply, socket}
  end

  def render(assigns) do
    ~L"""
    <div id="search">
      <h1>Find a Store</h1>
      <form phx-submit="zip-query">
        <input type="text" name="zip" value="<%= @zip %>" autofocus autocomplete="off" <%= if @loading, do: "readonly" %>>
        <button type="submit">
          <img src="images/search.svg" />
        </button>
      </form>
      <form phx-submit="city-query" phx-change="city-suggest">
        <input
          type="text"
          name="city"
          value="<%= @city %>"
          autocomplete="off"
          phx-debounce="1000"
          list="matches"
          <%= if @loading, do: "readonly" %> />

          <button type="submit">
          <img src="images/search.svg" />
        </button>
      </form>

      <datalist id="matches">
        <%= for match <- @matches do %>
          <option value="<%= match %>"><%= match %></option>
        <% end %>
      </datalist>

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
