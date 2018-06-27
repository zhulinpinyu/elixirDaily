defmodule CurrentCurrency.PageProcessor do
  import Plug.Conn

  alias CurrentCurrency.CurrencyAPI

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> fetch_currency
    |> build_page
  end

  defp fetch_currency(conn) do
    assign(conn, :currency, CurrencyAPI.currency())
  end

  defp build_page(conn) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, render_page(conn))
  end

  defp render_page(conn) do
    """
    <!DOCTYPE html>
    <html>
      <head>
        <title>Currency|USD -> CNY|HKD -> CNY</title>
        <style>
          html {
            background-color: #252839;
            color: #f2b632;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
            font-size: 24px;
            text-align: center;
          }
          div {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);;
            padding: 3rem;
            border: 6px solid #f2b632;
            border-radius: 6px;
          }
          p {
            margin: 1rem 0;
          }
          p:first-of-type {
            font-size: 0.8rem;
            line-height: 1rem;
          }
          p:last-of-type {
            font-size: 1.4rem;
          }
        </style>
      </head>
      <body>
        <div>
          <p>Current 1 USD value is ￥#{conn.assigns[:currency]["USD_CNY"]["val"]}</p>
          <p>Current 1 HKD value is ￥#{conn.assigns[:currency]["HKD_CNY"]["val"]}</p>
        </div>
      </body>

    </html>
    """
  end
end
