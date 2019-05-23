defmodule FreedomTest do
  use ExUnit.Case
  doctest Freedom

  test "greets the world" do
    assert Freedom.hello() == :world
  end
end
