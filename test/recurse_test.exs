defmodule RecurseTest do
  use ExUnit.Case
  doctest Recurse

  test "greets the world" do
    assert Recurse.hello() == :world
  end
end
