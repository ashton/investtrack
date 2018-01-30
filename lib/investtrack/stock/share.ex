defmodule Investtrack.Stock.Share do
  use Ecto.Schema
  import Ecto.Changeset
  alias Investtrack.Stock.Share


  schema "shares" do
    field :code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Share{} = share, attrs) do
    share
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
    |> unique_constraint(:code)
  end
end
