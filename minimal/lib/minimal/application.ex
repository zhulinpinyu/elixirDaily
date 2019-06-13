defmodule Minimal.Application do
  def start do
    IO.puts "Hello"
    {:ok, self()}
  end
end
