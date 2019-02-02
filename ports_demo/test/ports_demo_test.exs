defmodule PortsDemoTest do
  use ExUnit.Case
  doctest PortsDemo

  test "greets the world" do
    assert PortsDemo.hello() == :world
  end
end
