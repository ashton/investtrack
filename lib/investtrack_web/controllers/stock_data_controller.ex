defmodule InvesttrackWeb.StockDataController do
  use InvesttrackWeb, :controller

  alias Investtrack.HistoricalData

  action_fallback InvesttrackWeb.FallbackController

  def index(conn, _params) do
    stock_historical_data = HistoricalData.list_stock_historical_data()
    render(conn, "index.json", stock_historical_data: stock_historical_data)
  end

  def show(conn, %{"id" => id}) do
    stock_data = HistoricalData.get_stock_data!(id)
    render(conn, "show.json", stock_data: stock_data)
  end
end
