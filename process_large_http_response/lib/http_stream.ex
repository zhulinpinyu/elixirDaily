defmodule HTTPStream do
  def get(url) do
    Stream.resource(
      #start_fun
      fn ->
        HTTPoison.get!(
          url,
          %{},
          [stream_to: self(), async: :once])
      end,
      #next_fun
      fn %HTTPoison.AsyncResponse{id: id} = resp ->
        receive do
          %HTTPoison.AsyncStatus{id: ^id, code: code} ->
            IO.inspect(code, label: "Status: ")
            HTTPoison.stream_next(resp)
            {[], resp}
          %HTTPoison.AsyncHeaders{id: ^id, headers: headers} ->
            IO.inspect(headers, label: "Headers: ")
            HTTPoison.stream_next(resp)
            {[], resp}
          %HTTPoison.AsyncChunk{id: ^id, chunk: chunk} ->
            IO.inspect(chunk, label: "Chunk: ")
            HTTPoison.stream_next(resp)
            {[chunk], resp}
          %HTTPoison.AsyncEnd{id: ^id} ->
            {:halt, resp}
        after
          5_000 -> raise "receive timeout"
        end
      end,
      #end_fun
      fn resp -> :hackney.stop_async(resp.id) end
    )
  end
end
