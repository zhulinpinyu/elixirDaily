defmodule UserLiveview.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :phone_number, :string

    timestamps()
  end

  @phone ~r/^\d{11}$/
  @email ~r/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone_number])
    |> validate_required([:name, :email, :phone_number])
    |> validate_format(:name, ~r/^[a-zA-Z0-9_]/, message: "name numbers letters or underscore")
    |> validate_length(:name, max: 12)
    |> validate_format(:email, @email, message: "must valid email address")
    |> validate_format(:phone_number, @phone, message: "must be valid phone")
    |> unique_constraint(:email)
  end
end
