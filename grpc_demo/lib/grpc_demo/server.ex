defmodule GrpcDemo.User.Server do
  use GRPC.Server, service: GrpcDemo.User.Service

  def create(request, _stream) do
    user = UserDB.add_user(%{
      name: request.name,
      age: request.age,
      birth: request.birth
    })

    GrpcDemo.UserReply.new(user)
  end

  def get(request, _stream) do
    case UserDB.get_user(request.id) do
      nil -> raise GRPC.RPCError, status: :not_found
      user -> GrpcDemo.UserReply.new(user)
    end
  end
end
