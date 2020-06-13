defmodule LiveViewStudioWeb.FilterLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Boats

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        type: "",
        prices: [],
        boats: Boats.list_boats()
      )

    {:ok, socket}
  end

  def handle_event("filter", %{"type" => type, "prices" => prices}, socket) do
    params = [type: type, prices: prices]

    socket =
      assign(
        socket,
        [boats: Boats.list_boats(params)] ++ params
      )

    {:noreply, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>每日游艇租赁</h1>
    <div id="filter">
      <form phx-change="filter">
        <div class="filters">
          <select name="type">
            <%= options_for_select(type_options(), @type)%>
          </select>
          <div class="prices">
            <input type="hidden" name="prices[]" value=""/>
            <%= for price <- ["$", "$$", "$$$"] do %>
              <%= price_checkbox([price: price, checked: price in @prices])%>
            <% end %>
          </div>
        </div>
      </form>
      <div class="boats">
        <%= for boat <- @boats do %>
          <div class="card">
            <img src=<%= boat.image %> />
            <div class="content">
              <div class="model">
                <%= boat.model %>
              </div>
              <div class="details">
                <div class="price">
                  <%= boat.price %>
                </div>
                <div class="type">
                  <%= boat.type %>
                </div>
              </div>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  defp price_checkbox(opts) do
    assigns = Enum.into(opts, %{})

    ~L"""
    <input type="checkbox" name="prices[]" id="<%= @price %>" value="<%= @price %>"
      <%= if @checked, do: "checked" %>
    />
    <label for="<%= @price %>"><%= @price %></label>
    """
  end

  defp type_options do
    [
      "All Types": "",
      Fishing: "fishing",
      Sporting: "sporting",
      Sailing: "sailing"
    ]
  end
end
