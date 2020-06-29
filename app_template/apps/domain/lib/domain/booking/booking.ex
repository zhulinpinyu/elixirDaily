defmodule Booking do
  alias Booking.{Item, Repo}

  @repo Repo

  def list_items do
    @repo.all(Item)
  end
end
