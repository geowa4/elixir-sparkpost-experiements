defmodule RocDev.NewsletterTest do
  use ExUnit.Case
  doctest RocDev.Newsletter

  test "greets the world" do
    assert RocDev.Newsletter.hello() == :world
  end
end
