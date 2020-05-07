defmodule Quantum.Telemetry.Metrics do
  alias Quantum.Telemetry.StatsdReporter

  def handle_event([:phoenix, :request, :register], %{duration: dur}, metadata, _config) do
    StatsdReporter.increment("phoenix.request.success", 1, tags: [metadata.request_path])
    StatsdReporter.timing("phoenix.request.success", dur, tags: [metadata.request_path])
  end

  def handle_event([:phoenix, :request], %{duration: dur}, _metadata, _config) do
    StatsdReporter.increment("phoenix.request.success", 1)
    StatsdReporter.timing("phoenix.request.success", dur)
  end
end
