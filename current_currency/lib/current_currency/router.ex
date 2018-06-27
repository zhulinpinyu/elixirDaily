defmodule CurrentCurrency.Router do
  use Plug.Router

  alias CurrentCurrency.PageProcessor

  plug :match
  plug :dispatch

  get "/about" do
    send_resp(conn, 200, "This is about page")
  end

  match _ do
    PageProcessor.call(conn, PageProcessor.init([]))
  end
end
