defmodule TinyAssertTest do
  use ExUnit.Case
  doctest TinyAssert

  test "greets the world" do
    assert TinyAssert.hello() == :world
  end
end
