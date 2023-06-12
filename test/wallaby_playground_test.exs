defmodule WallabyPlaygroundTest do
  use ExUnit.Case
  doctest WallabyPlayground

  test "greets the world" do
    assert WallabyPlayground.hello() == :world
  end
end
