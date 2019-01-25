defmodule HttpServerDemoTest do
  use ExUnit.Case
  doctest HttpServerDemo

  test "greets the world" do
    assert HttpServerDemo.hello() == :world
  end
end
