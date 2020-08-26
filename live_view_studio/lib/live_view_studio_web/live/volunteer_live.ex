defmodule LiveViewStudioWeb.VolunteerLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Volunteers
  alias LiveViewStudio.Volunteers.Volunteer

  def mount(_params, _session, socket) do
    if connected?(socket), do: Volunteers.subscribe()
    volunteers = Volunteers.list_volunteers()
    changeset = Volunteers.change_volunteer(%Volunteer{})

    socket =
      assign(socket,
        volunteers: volunteers,
        changeset: changeset
      )

    {:ok, socket}
  end

  def handle_event("save", %{"volunteer" => params}, socket) do
    socket =
      case Volunteers.create_volunteer(params) do
        {:ok, _volunteer} ->
          assign(socket,
            changeset: Volunteers.change_volunteer(%Volunteer{})
          )

        {:error, %Ecto.Changeset{} = changeset} ->
          assign(socket, changeset: changeset)
      end

    {:noreply, socket}
  end

  def handle_event("validate", %{"volunteer" => params}, socket) do
    changeset =
      %Volunteer{}
      |> Volunteers.change_volunteer(params)
      |> Map.put(:action, :insert)

    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event("toggle-status", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)
    Volunteers.update_volunteer(volunteer, %{checked_out: !volunteer.checked_out})

    {:noreply, socket}
  end

  def handle_info({:volunteer_created, volunteer}, socket) do
    {:noreply, assign(socket, volunteers: [volunteer | socket.assigns.volunteers])}
  end

  def handle_info({:volunteer_updated, %{id: id} = volunteer}, socket) do
    socket =
      update(
        socket,
        :volunteers,
        fn volunteers ->
          Enum.map(
            volunteers,
            fn
              %{id: ^id} -> volunteer
              v -> v
            end
          )
        end
      )

    {:noreply, socket}
  end
end
