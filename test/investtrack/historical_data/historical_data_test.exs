defmodule Investtrack.HistoricalDataTest do
  use Investtrack.DataCase

  alias Investtrack.HistoricalData

  describe "stock_historical_data" do
    alias Investtrack.HistoricalData.StockData

    @valid_attrs %{avg_price: "120.5", best_buy: "120.5", best_sell: "120.5", code: "some code", date: ~N[2010-04-17 14:00:00.000000], last_price: "120.5", market_type: "some market_type", max_price: "120.5", min_price: "120.5", name: "some name", opening_price: "120.5", trade_amount: 42, trade_count: 42}
    @update_attrs %{avg_price: "456.7", best_buy: "456.7", best_sell: "456.7", code: "some updated code", date: ~N[2011-05-18 15:01:01.000000], last_price: "456.7", market_type: "some updated market_type", max_price: "456.7", min_price: "456.7", name: "some updated name", opening_price: "456.7", trade_amount: 43, trade_count: 43}
    @invalid_attrs %{avg_price: nil, best_buy: nil, best_sell: nil, code: nil, date: nil, last_price: nil, market_type: nil, max_price: nil, min_price: nil, name: nil, opening_price: nil, trade_amount: nil, trade_count: nil}

    def stock_data_fixture(attrs \\ %{}) do
      {:ok, stock_data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HistoricalData.create_stock_data()

      stock_data
    end

    test "list_stock_historical_data/0 returns all stock_historical_data" do
      stock_data = stock_data_fixture()
      assert HistoricalData.list_stock_historical_data() == [stock_data]
    end

    test "get_stock_data!/1 returns the stock_data with given id" do
      stock_data = stock_data_fixture()
      assert HistoricalData.get_stock_data!(stock_data.id) == stock_data
    end

    test "create_stock_data/1 with valid data creates a stock_data" do
      assert {:ok, %StockData{} = stock_data} = HistoricalData.create_stock_data(@valid_attrs)
      assert stock_data.avg_price == Decimal.new("120.5")
      assert stock_data.best_buy == Decimal.new("120.5")
      assert stock_data.best_sell == Decimal.new("120.5")
      assert stock_data.code == "some code"
      assert stock_data.date == ~N[2010-04-17 14:00:00.000000]
      assert stock_data.last_price == Decimal.new("120.5")
      assert stock_data.market_type == "some market_type"
      assert stock_data.max_price == Decimal.new("120.5")
      assert stock_data.min_price == Decimal.new("120.5")
      assert stock_data.name == "some name"
      assert stock_data.opening_price == Decimal.new("120.5")
      assert stock_data.trade_amount == 42
      assert stock_data.trade_count == 42
    end

    test "create_stock_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HistoricalData.create_stock_data(@invalid_attrs)
    end

    test "update_stock_data/2 with valid data updates the stock_data" do
      stock_data = stock_data_fixture()
      assert {:ok, stock_data} = HistoricalData.update_stock_data(stock_data, @update_attrs)
      assert %StockData{} = stock_data
      assert stock_data.avg_price == Decimal.new("456.7")
      assert stock_data.best_buy == Decimal.new("456.7")
      assert stock_data.best_sell == Decimal.new("456.7")
      assert stock_data.code == "some updated code"
      assert stock_data.date == ~N[2011-05-18 15:01:01.000000]
      assert stock_data.last_price == Decimal.new("456.7")
      assert stock_data.market_type == "some updated market_type"
      assert stock_data.max_price == Decimal.new("456.7")
      assert stock_data.min_price == Decimal.new("456.7")
      assert stock_data.name == "some updated name"
      assert stock_data.opening_price == Decimal.new("456.7")
      assert stock_data.trade_amount == 43
      assert stock_data.trade_count == 43
    end

    test "update_stock_data/2 with invalid data returns error changeset" do
      stock_data = stock_data_fixture()
      assert {:error, %Ecto.Changeset{}} = HistoricalData.update_stock_data(stock_data, @invalid_attrs)
      assert stock_data == HistoricalData.get_stock_data!(stock_data.id)
    end

    test "delete_stock_data/1 deletes the stock_data" do
      stock_data = stock_data_fixture()
      assert {:ok, %StockData{}} = HistoricalData.delete_stock_data(stock_data)
      assert_raise Ecto.NoResultsError, fn -> HistoricalData.get_stock_data!(stock_data.id) end
    end

    test "change_stock_data/1 returns a stock_data changeset" do
      stock_data = stock_data_fixture()
      assert %Ecto.Changeset{} = HistoricalData.change_stock_data(stock_data)
    end
  end
end
