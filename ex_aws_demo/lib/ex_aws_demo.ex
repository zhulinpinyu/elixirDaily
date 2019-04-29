defmodule ExAwsDemo do
  @moduledoc """
  配置环境变量： `AWS_ACCESS_KEY_ID` `AWS_SECRET_ACCESS_KEY`
  """


  @doc """
  Example: list bucket `myBucket` content
  """
  def list do
    ExAws.S3.list_objects("myBucket") |> ExAws.request(region: "cn-north-1")
  end

  @doc """
  Example: download `filename` from bucket myBucket path on `catalog/filename`, and save to `./filename`
  """
  def download(filename) do
    ExAws.S3.download_file("myBucket", "catalog/#{filename}", "./#{filename}")
    |> ExAws.request(region: "cn-north-1")
  end
end
