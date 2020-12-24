defmodule GrpcDemo.EndPoint do
  use GRPC.Endpoint

  intercept GRPC.Logger.Server
  run GrpcDemo.User.Server
end
