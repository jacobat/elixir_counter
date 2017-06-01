defmodule Counter do
  def start_link do
    Task.start_link(fn -> loop(0) end)
  end

  defp loop(count) do
    receive do
      {:get, caller} ->
        send caller, count
        loop(count)
      {:increment} ->
        loop(count + 1)
      {:decrement} ->
        loop(count - 1)
    end
  end
end
