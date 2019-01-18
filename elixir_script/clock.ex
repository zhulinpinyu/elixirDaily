defmodule Clock do
  def start do
    time_str =
      Time.utc_now()
      |> Time.truncate(:second)
      |> Time.to_string()

    IO.write("\r#{time_str}")
    Process.sleep(1000)
    start()
  end
end

Clock.start
