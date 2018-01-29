defmodule Investtrack.HistoricalData.StockData do
  use Ecto.Schema
  import Ecto.Changeset
  alias Investtrack.HistoricalData.StockData


  schema "stock_historical_data" do
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
  def changeset(%StockData{} = stock_data, attrs) do
    stock_data
    |> cast(attrs, [:code, :market_type, :name, :opening_price, :max_price, :min_price, :avg_price, :last_price, :best_buy, :best_sell, :trade_count, :trade_amount, :date, :trade_volume])
    |> validate_required([:code, :market_type, :name, :opening_price, :max_price, :min_price, :avg_price, :last_price, :best_buy, :best_sell, :trade_count, :trade_amount, :date, :trade_volume])
  end
end
