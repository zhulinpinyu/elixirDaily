defmodule LiveViewTodolist.Repo do
  use Ecto.Repo,
    otp_app: :live_view_todolist,
    adapter: Ecto.Adapters.Postgres
end
