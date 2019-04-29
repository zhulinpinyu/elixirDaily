defmodule ExAwsDemoTest do
  use ExUnit.Case
  doctest ExAwsDemo

  test "greets the world" do
    assert ExAwsDemo.hello() == :world
  end
end
