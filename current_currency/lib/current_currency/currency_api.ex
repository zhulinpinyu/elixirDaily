defmodule CurrentCurrency.CurrencyAPI do
  @api_url "https://free.currencyconverterapi.com/api/v5/convert?q=USD_CNY,HKD_CNY&compact=y"

  def currency do
    #%{"HKD_CNY" => %{"val" => 0.840963}, "USD_CNY" => %{"val" => 6.599303}}
    case HTTPoison.get(@api_url) do
      {:ok, response} ->
        response.body |> Jason.decode!
      {:error, _} ->
        nil
    end
  end
end
