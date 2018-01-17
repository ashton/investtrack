defmodule Investtrack.Price.Stock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Investtrack.Price.Stock


  schema "stock_prices" do
    field :avg_price, :decimal
    field :best_buy, :decimal
    field :best_sell, :decimal
    field :code, :string
    field :date, :naive_datetime
    field :last_price, :decimal
    field :market_type, :string
    field :max_price, :decimal
    field :min_price, :decimal
    field :name, :string
    field :opening_price, :decimal
    field :trade_amount, :integer
    field :trade_count, :integer
    field :trade_volume, :decimal

    timestamps()
  end

  @doc false
  def changeset(%Stock{} = stock, attrs) do
    stock
    |> cast(attrs, [:code, :market_type, :name, :opening_price, :max_price, :min_price, :avg_price, :last_price, :best_buy, :best_sell, :trade_count, :trade_amount, :trade_volume, :date])
    |> validate_required([:code, :market_type, :name, :opening_price, :max_price, :min_price, :avg_price, :last_price, :best_buy, :best_sell, :trade_count, :trade_amount, :trade_volume, :date])
  end
end
