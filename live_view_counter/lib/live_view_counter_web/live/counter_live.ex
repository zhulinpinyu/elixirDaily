defmodule LiveViewCounterWeb.CounterLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <h1>当前计数结果：<%= @count %></h1>
      <button phx-click="dec">-</button>
      <button phx-click="inc">+</button>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end
end
