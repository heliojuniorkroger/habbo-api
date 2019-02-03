defmodule HabboApiTest do
  use ExUnit.Case
  doctest HabboApi

  test "greets the world" do
    assert HabboApi.hello() == :world
  end
end
