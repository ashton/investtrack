defmodule InvesttrackWeb.StockDataController do
  use InvesttrackWeb, :controller

  alias Investtrack.HistoricalData

  action_fallback InvesttrackWeb.FallbackController

  def show(conn, %{"code" => code}) do
    stock_history = HistoricalData.list_stock_historical_data(code)
    render(conn, "stock_data_list.json", stock_history: stock_history)
  end
end
