defmodule GrpcDemo.CreateRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          age: integer,
          birth: String.t()
        }

  defstruct [:name, :age, :birth]

  field :name, 1, type: :string
  field :age, 2, type: :int32
  field :birth, 3, type: :string
end

defmodule GrpcDemo.UserReply do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          age: integer,
          birth: String.t()
        }

  defstruct [:id, :name, :age, :birth]

  field :id, 1, type: :int32
  field :name, 2, type: :string
  field :age, 3, type: :int32
  field :birth, 4, type: :string
end

defmodule GrpcDemo.GetRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer
        }

  defstruct [:id]

  field :id, 1, type: :int32
end

defmodule GrpcDemo.User.Service do
  @moduledoc false
  use GRPC.Service, name: "grpc_demo.User"

  rpc :Create, GrpcDemo.CreateRequest, GrpcDemo.UserReply

  rpc :Get, GrpcDemo.GetRequest, GrpcDemo.UserReply
end

defmodule GrpcDemo.User.Stub do
  @moduledoc false
  use GRPC.Stub, service: GrpcDemo.User.Service
end
