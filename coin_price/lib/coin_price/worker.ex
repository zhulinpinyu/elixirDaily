defmodule CoinPrice.Worker do
  use GenServer

  def start_link(args) do
    id = Map.get(args, :id)
    GenServer.start_link(__MODULE__, args, name: id)
  end

  def init(state) do
    schedule_price_fetch()
    {:ok, state}
  end

  def handle_info(:price_fetch, state) do
    update_state =
      state
      |> Map.get(:id)
      |> price_fetch()
      |> update_state(state)

    if update_state[:price] != state[:price] do
      IO.puts "current #{update_state[:name]} price is #{update_state[:price]}"
    end

    {:noreply, update_state}
  end

  def price_fetch(id) do
    id
    |> Atom.to_string()
    |> String.upcase()
    |> url()
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!
  end

  def url(id) do
    "http://coincap.io/page/" <> id
  end

  def schedule_price_fetch() do
    Process.send_after(self(), :price_fetch, 5_000)
  end

  defp update_state(%{"display_name" => name, "price" => price}, existing_state) do
    Map.merge(existing_state, %{name: name, price: price})
  end
end
