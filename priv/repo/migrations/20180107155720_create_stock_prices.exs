defmodule Investtrack.Repo.Migrations.CreateStockPrices do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;"

    create table(:stock_prices) do
      add :code, :string
      add :market_type, :string
      add :name, :string
      add :opening_price, :decimal
      add :max_price, :decimal
      add :min_price, :decimal
      add :avg_price, :decimal
      add :last_price, :decimal
      add :best_buy, :decimal
      add :best_sell, :decimal
      add :trade_count, :integer
      add :trade_amount, :integer
      add :trade_volume, :decimal
      add :date, :naive_datetime, primary_key: true

      timestamps()
    end

    execute "SELECT create_hypertable('stock_prices', 'date');"
  end
end
