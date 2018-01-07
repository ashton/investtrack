defmodule Investtrack.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Investtrack.Account.User
  alias Investtrack.Account


  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required(get_required_fields(user))
    |> unique_constraint(:email)
    |> hash_password
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: new_password}} = changeset) do
    change changeset, %{password: Account.hash_password(new_password)}
  end

  defp hash_password(%Ecto.Changeset{} = changeset), do: changeset

  defp get_required_fields(%User{} = user) do
    case user do
      %User{id: _user_id} -> [:name, :email]
      _ -> [:name, :email, :password]
    end
  end
end
