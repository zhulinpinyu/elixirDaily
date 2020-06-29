defmodule Booking.Item do
  defstruct [:id, :person, :place]

  alias __MODULE__

  def new(person, place) do
    %Item{
      id: random_str(32),
      person: person,
      place: place
    }
  end

  defp random_str(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64()
    |> binary_part(0, length)
  end
end
