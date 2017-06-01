require Logger

defmodule Counter.Srv do
  def accept(port) do
    # The options below mean:
    #
    # 1. `:binary` - receives data as binaries (instead of lists)
    # 2. `packet: :line` - receives data line by line
    # 3. `active: false` - blocks on `:gen_tcp.recv/2` until data is available
    # 4. `reuseaddr: true` - allows us to reuse the address if the listener crashes
    #
    {:ok, socket} = :gen_tcp.listen(port,
                      [:binary, packet: :line, active: false, reuseaddr: true])
    Logger.info "Accepting connections on port #{port}"
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Logger.info "New connection on socket"
    {:ok, counter} = Counter.start_link
    serve(client, counter)
    loop_acceptor(socket)
  end

  defp serve(socket, counter) do
    Logger.info "Serving..."

    socket
    |> read_line(counter)
    |> write_line(socket, counter)

    serve(socket, counter)
  end

  defp read_line(socket, counter) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    Counter.increment(counter)
    data
  end

  defp write_line(_line, socket, counter) do
    :gen_tcp.send(socket, "messages received: #{Counter.get(counter)}")
  end
end
