defmodule InGenserverTest do
  use ExUnit.Case
  doctest InGenserver

  test "greets the world" do
    assert InGenserver.hello() == :world
  end
end
