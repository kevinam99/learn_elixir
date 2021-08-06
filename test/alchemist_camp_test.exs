defmodule AlchemistCampTest do
  use ExUnit.Case
  doctest AlchemistCamp

  test "greets the world" do
    assert AlchemistCamp.hello() == :world
  end

  test "guess name" do
    assert NameGuess.getname() == :ok
  end
end
