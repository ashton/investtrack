defmodule InvesttrackWeb.StockDataControllerTest do
  use InvesttrackWeb.ConnCase

  alias Investtrack.HistoricalData
  alias Investtrack.HistoricalData.StockData

  @create_attrs %{avg_price: "120.5", best_buy: "120.5", best_sell: "120.5", code: "some code", date: ~N[2010-04-17 14:00:00.000000], last_price: "120.5", market_type: "some market_type", max_price: "120.5", min_price: "120.5", name: "some name", opening_price: "120.5", trade_amount: 42, trade_count: 42}
  @update_attrs %{avg_price: "456.7", best_buy: "456.7", best_sell: "456.7", code: "some updated code", date: ~N[2011-05-18 15:01:01.000000], last_price: "456.7", market_type: "some updated market_type", max_price: "456.7", min_price: "456.7", name: "some updated name", opening_price: "456.7", trade_amount: 43, trade_count: 43}
  @invalid_attrs %{avg_price: nil, best_buy: nil, best_sell: nil, code: nil, date: nil, last_price: nil, market_type: nil, max_price: nil, min_price: nil, name: nil, opening_price: nil, trade_amount: nil, trade_count: nil}

  def fixture(:stock_data) do
    {:ok, stock_data} = HistoricalData.create_stock_data(@create_attrs)
    stock_data
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all stock_historical_data", %{conn: conn} do
      conn = get conn, stock_data_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create stock_data" do
    test "renders stock_data when data is valid", %{conn: conn} do
      conn = post conn, stock_data_path(conn, :create), stock_data: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, stock_data_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "avg_price" => "120.5",
        "best_buy" => "120.5",
        "best_sell" => "120.5",
        "code" => "some code",
        "date" => ~N[2010-04-17 14:00:00.000000],
        "last_price" => "120.5",
        "market_type" => "some market_type",
        "max_price" => "120.5",
        "min_price" => "120.5",
        "name" => "some name",
        "opening_price" => "120.5",
        "trade_amount" => 42,
        "trade_count" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, stock_data_path(conn, :create), stock_data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update stock_data" do
    setup [:create_stock_data]

    test "renders stock_data when data is valid", %{conn: conn, stock_data: %StockData{id: id} = stock_data} do
      conn = put conn, stock_data_path(conn, :update, stock_data), stock_data: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, stock_data_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "avg_price" => "456.7",
        "best_buy" => "456.7",
        "best_sell" => "456.7",
        "code" => "some updated code",
        "date" => ~N[2011-05-18 15:01:01.000000],
        "last_price" => "456.7",
        "market_type" => "some updated market_type",
        "max_price" => "456.7",
        "min_price" => "456.7",
        "name" => "some updated name",
        "opening_price" => "456.7",
        "trade_amount" => 43,
        "trade_count" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, stock_data: stock_data} do
      conn = put conn, stock_data_path(conn, :update, stock_data), stock_data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete stock_data" do
    setup [:create_stock_data]

    test "deletes chosen stock_data", %{conn: conn, stock_data: stock_data} do
      conn = delete conn, stock_data_path(conn, :delete, stock_data)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, stock_data_path(conn, :show, stock_data)
      end
    end
  end

  defp create_stock_data(_) do
    stock_data = fixture(:stock_data)
    {:ok, stock_data: stock_data}
  end
end
