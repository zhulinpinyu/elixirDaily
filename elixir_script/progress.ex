defmodule Progress do
  @rounding_precision 2
  @filled "█"
  @unfilled "░"
  @progress_bar_size 50

  def bar(count, total) do
    complete_percent = percent_complete(count, total)
    divisor = 100 / @progress_bar_size
    complete_count = round(complete_percent / divisor)
    incomplete_count = @progress_bar_size - complete_count

    complete = String.duplicate(@filled, complete_count)
    incomplete = String.duplicate(@unfilled, incomplete_count)

    "#{complete}#{incomplete} #{complete_percent}%"
  end

  defp percent_complete(count, total) do
    Float.round(100.0 * count / total, @rounding_precision)
  end
end

total = 50

Enum.each(1..total, fn task ->
  IO.write("\r#{Progress.bar(task, total)}")
  Process.sleep(50)
end)
IO.write("\n")
