defmodule LiveViewTodolistWeb.TodoLive do
  use Phoenix.LiveView

  alias LiveViewTodolist.Todos
  alias LiveViewTodolistWeb.TodoView

  def mount(_session, socket) do
    Todos.subscribe()
    {:ok, fetch(socket)}
  end

  def render(assigns) do
    TodoView.render("todo_list.html", assigns)
  end

  def handle_event("add", %{"todo" => todo}, socket) do
    Todos.create_todo(todo)
    {:noreply, socket}
  end

  def handle_event("toggle_done", id, socket) do
    todo = Todos.get_todo!(id)

    Todos.update_todo(todo, %{done: !todo.done})
    {:noreply, socket}
  end

  def handle_info({Todos, [:todo | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, todos: Todos.list_todos())
  end
end
