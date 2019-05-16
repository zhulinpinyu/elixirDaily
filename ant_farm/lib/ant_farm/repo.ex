defmodule AntFarm.Repo do
  use Ecto.Repo,
    otp_app: :ant_farm,
    adapter: Ecto.Adapters.Postgres
end
