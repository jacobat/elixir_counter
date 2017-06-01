defmodule CounterTest do
  use ExUnit.Case
  doctest Counter

  test "is zero at first" do
    {:ok, pid} = Counter.start_link
    send pid, {:get, self()}
    receive do
      count -> assert count == 0
    end
  end

  test "can be incremented to one" do
    {:ok, pid} = Counter.start_link
    send pid, {:increment}
    send pid, {:get, self()}
    receive do
      count -> assert count == 1
    end
  end

  test "can also be decremented" do
    {:ok, pid} = Counter.start_link
    send pid, {:increment}
    send pid, {:increment}
    send pid, {:decrement}
    send pid, {:get, self()}
    receive do
      count -> assert count == 1
    end
  end
end
