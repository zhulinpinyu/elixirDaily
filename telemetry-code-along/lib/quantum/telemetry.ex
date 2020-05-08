defmodule Quantum.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      {TelemetryMetricsStatsd, metrics: metrics(), formatter: :datadog}
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end

  defp metrics() do
    [
      summary(
        "phoenix.router_dispatch.stop.duration",
        unit: {:native, :millisecond},
        tags: [:plug, :plug_opts]
      ),
      counter(
        "phoenix.router_dispatch.stop.count",
        tag_values: &__MODULE__.endpoint_metadata/1,
        tags: [:plug, :plug_opts, :status]
      )
    ]
  end

  def endpoint_metadata(%{conn: %{status: status}, plug: plug, plug_opts: plug_opts}) do
    %{ status: status, plug: plug, plug_opts: plug_opts }
  end
end
