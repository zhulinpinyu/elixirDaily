defmodule LiveViewStudioWeb.SalesDashboardLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Sales
  import Number.Currency

  def mount(_params, _session, socket) do
    if(connected?(socket)) do
      :timer.send_interval(1000, self(), :tick)
    end

    {:ok, assign_stats(socket)}
  end

  def render(assigns) do
    ~L"""
    <div id="dashboard">
      <h1>Sales Dashboard</h2>
      <div class="stats">
        <div class="stat">
          <span class="value"><%= @new_orders %></span>
          <span class="name">新订单量</span>
        </div>
        <div class="stat">
          <span class="value"><%= number_to_currency(@sales_amount) %></span>
          <span class="name">销售额</span>
        </div>
        <div class="stat">
          <span class="value"><%= @satisfication %>%</span>
          <span class="name">满意度</span>
        </div>
      </div>

      <button phx-click="refresh">
        <img src="images/refresh.svg"/>
        刷新
      </button>
    </div>
    """
  end

  def handle_event("refresh", _, socket) do
    {:noreply, assign_stats(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, assign_stats(socket)}
  end

  defp assign_stats(socket) do
    assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfication: Sales.satisfication()
    )
  end
end
