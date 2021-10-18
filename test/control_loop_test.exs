defmodule ControlLoopTest do
  use ExUnit.Case
  doctest ControlLoop

  test "greets the world" do
    assert ControlLoop.hello() == :world
  end
end
