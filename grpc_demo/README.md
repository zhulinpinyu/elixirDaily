# gRPC Elixir Demo 之 Server

https://blog.appsignal.com/2020/03/24/how-to-use-grpc-in-elixir.html

**Demo 环境**：`Mac OS`

**相关依赖：**
```
brew install protobuf # 编译.proto 文件
brew install grpcurl # 方便本地测试
```
其他操作系统：https://github.com/protocolbuffers/protobuf/blob/master/src/README.md


**Elixir 相关依赖**

```elixir
mix escript.install hex protobuf
```

 若版本管理使用asdf则需 `asdf reshim elixir`



**生成Elixir文件**
 ```
 protoc --elixir_out=plugins=grpc:./lib grpc_demo.proto
 ```


 **启动GRPC server**

 ```
 iex -S mix grpc.server
 ```

 **grpcurl 简单测试**

```
grpcurl -plaintext -proto grpc_demo.proto -d '{"name": "mlx", "age": 31, "birth": "1990"}' 0.0.0.0:50051 grpc_demo.User.Create
{
  "id": 2,
  "name": "mlx",
  "age": 31,
  "birth": "1990"
}
```
```
grpcurl -plaintext -proto grpc_demo.proto -d '{"id": 1}' 0.0.0.0:50051 grpc_demo.User.Get
{
  "name": "mlx",
  "age": 31,
  "birth": "1990"
}
```
```
grpcurl -plaintext -proto grpc_demo.proto -d '{"id": 3}' 0.0.0.0:50051 grpc_demo.User.Get
ERROR:
  Code: NotFound
  Message: Some requested entity (e.g., file or directory) was not found
 ```