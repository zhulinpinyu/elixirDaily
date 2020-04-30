defmodule CreateExcelDemoTest do
  use ExUnit.Case
  doctest CreateExcelDemo

  test "greets the world" do
    assert CreateExcelDemo.hello() == :world
  end
end
