defmodule CounterTest do
  use ExUnit.Case, async: true
  doctest Counter

  test "is zero at first" do
    {:ok, pid} = Counter.start_link
    assert Counter.get(pid) == 0
  end

  test "can be incremented to one" do
    {:ok, pid} = Counter.start_link
    assert Counter.get(pid) == 0

    Counter.increment(pid)
    assert Counter.get(pid) == 1
  end

  test "can also be decremented" do
    {:ok, pid} = Counter.start_link
    assert Counter.get(pid) == 0

    Counter.increment(pid)
    Counter.increment(pid)
    Counter.decrement(pid)
    assert Counter.get(pid) == 1
  end
end
