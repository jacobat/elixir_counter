defmodule Counter do
  def start_link do
    Agent.start_link(fn -> 0 end)
  end

  def get(counter) do
    Agent.get(counter, &(&1))
  end

  def increment(counter) do
    Agent.update(counter, fn count -> count + 1 end)
  end

  def decrement(counter) do
    Agent.update(counter, fn count -> count - 1 end)
  end
end
