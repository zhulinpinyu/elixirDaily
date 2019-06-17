defmodule Minimal.Application do
  def start(:normal, []) do
    Supervisor.start_link(
      [
        MinimalWeb.Endpoint
      ],
      strategy: :one_for_one
    )
  end
end
