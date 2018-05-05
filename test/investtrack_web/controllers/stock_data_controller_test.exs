defmodule InvesttrackWeb.StockDataControllerTest do
  use InvesttrackWeb.ConnCase

  alias Investtrack.HistoricalData

  @create_attrs %{avg_price: "120.5", best_buy: "120.5", best_sell: "120.5", code: "some code", date: ~N[2010-04-17 14:00:00.000000], last_price: "120.5", market_type: "some market_type", max_price: "120.5", min_price: "120.5", name: "some name", opening_price: "120.5", trade_amount: 42, trade_count: 42}

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
end
