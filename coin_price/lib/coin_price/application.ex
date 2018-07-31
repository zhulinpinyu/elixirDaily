defmodule CoinPrice.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = get_children()

    opts = [strategy: :one_for_one, name: CoinPrice.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_children() do
    Enum.map([:btc, :eth, :ltc], fn coin ->
      Supervisor.child_spec({CoinPrice.Worker, %{id: coin}}, id: coin)
    end)
  end
end
