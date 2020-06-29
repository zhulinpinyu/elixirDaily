defmodule ApiWeb.BookingController do
  use ApiWeb, :controller

  def index(conn, _params) do
    items = Booking.list_items()
    render(conn, "index.json", items: items)
  end
end
