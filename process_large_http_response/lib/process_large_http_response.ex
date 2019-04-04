defmodule ProcessLargeHttpResponse do
  @url "https://cdn.spacetelescope.org/archives/images/large/potw1913a.jpg"
  def download do
    @url
    |> HTTPStream.get()
    |> StreamGzip.gzip()
    |> Stream.into(File.stream!("big_pic.tif.gz"))
    |> Stream.run()
  end
end
