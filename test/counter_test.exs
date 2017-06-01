defmodule CounterTest do
  use ExUnit.Case, async: true
  doctest Counter

  setup do
    {:ok, counter} = Counter.start_link
    {:ok, counter: counter}
  end

  test "is zero at first", %{counter: pid} do
    assert Counter.get(pid) == 0
  end

  test "can be incremented to one", %{counter: pid} do
    assert Counter.get(pid) == 0

    Counter.increment(pid)
    assert Counter.get(pid) == 1
  end

  test "can also be decremented", %{counter: pid} do
    assert Counter.get(pid) == 0

    Counter.increment(pid)
    Counter.increment(pid)
    Counter.decrement(pid)
    assert Counter.get(pid) == 1
  end
end
