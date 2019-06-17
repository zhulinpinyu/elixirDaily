defmodule Minimal.Application do
  def start(:normal, []) do
    IO.puts "Hello Coco."
    {:ok, self()}
  end
end
