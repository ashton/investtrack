defmodule Investtrack.PriceTest do
  use Investtrack.DataCase

  alias Investtrack.Price

  describe "stock_prices" do
    alias Investtrack.Price.Stock

    @valid_attrs %{avg_price: "120.5", best_buy: "120.5", best_sell: "120.5", code: "some code", date: ~N[2010-04-17 14:00:00.000000], last_price: "120.5", market_type: "some market_type", max_price: "120.5", min_price: "120.5", name: "some name", opening_price: "120.5", trade_amount: 42, trade_count: 42}
    @update_attrs %{avg_price: "456.7", best_buy: "456.7", best_sell: "456.7", code: "some updated code", date: ~N[2011-05-18 15:01:01.000000], last_price: "456.7", market_type: "some updated market_type", max_price: "456.7", min_price: "456.7", name: "some updated name", opening_price: "456.7", trade_amount: 43, trade_count: 43}
    @invalid_attrs %{avg_price: nil, best_buy: nil, best_sell: nil, code: nil, date: nil, last_price: nil, market_type: nil, max_price: nil, min_price: nil, name: nil, opening_price: nil, trade_amount: nil, trade_count: nil}

    def stock_fixture(attrs \\ %{}) do
      {:ok, stock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Price.create_stock()

      stock
    end

    test "list_stock_prices/0 returns all stock_prices" do
      stock = stock_fixture()
      assert Price.list_stock_prices() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Price.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      assert {:ok, %Stock{} = stock} = Price.create_stock(@valid_attrs)
      assert stock.avg_price == Decimal.new("120.5")
      assert stock.best_buy == Decimal.new("120.5")
      assert stock.best_sell == Decimal.new("120.5")
      assert stock.code == "some code"
      assert stock.date == ~N[2010-04-17 14:00:00.000000]
      assert stock.last_price == Decimal.new("120.5")
      assert stock.market_type == "some market_type"
      assert stock.max_price == Decimal.new("120.5")
      assert stock.min_price == Decimal.new("120.5")
      assert stock.name == "some name"
      assert stock.opening_price == Decimal.new("120.5")
      assert stock.trade_amount == 42
      assert stock.trade_count == 42
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Price.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      assert {:ok, stock} = Price.update_stock(stock, @update_attrs)
      assert %Stock{} = stock
      assert stock.avg_price == Decimal.new("456.7")
      assert stock.best_buy == Decimal.new("456.7")
      assert stock.best_sell == Decimal.new("456.7")
      assert stock.code == "some updated code"
      assert stock.date == ~N[2011-05-18 15:01:01.000000]
      assert stock.last_price == Decimal.new("456.7")
      assert stock.market_type == "some updated market_type"
      assert stock.max_price == Decimal.new("456.7")
      assert stock.min_price == Decimal.new("456.7")
      assert stock.name == "some updated name"
      assert stock.opening_price == Decimal.new("456.7")
      assert stock.trade_amount == 43
      assert stock.trade_count == 43
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Price.update_stock(stock, @invalid_attrs)
      assert stock == Price.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Price.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Price.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Price.change_stock(stock)
    end
  end
end
