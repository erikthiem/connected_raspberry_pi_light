defmodule NetworkLedTest do
  use ExUnit.Case
  doctest NetworkLed

  test "greets the world" do
    assert NetworkLed.hello() == :world
  end
end
