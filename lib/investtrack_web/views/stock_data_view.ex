defmodule InvesttrackWeb.StockDataView do
  use InvesttrackWeb, :view
  alias InvesttrackWeb.StockDataView

  def render("stock_data_list.json", %{stock_history: stock_history}) do
    %{data: render_many(stock_history, StockDataView, "stock_data.json")}
  end

  def render("stock_data_object.json", %{stock_data: stock_data}) do
    %{data: render_one(stock_data, StockDataView, "stock_data.json")}
  end

  def render("stock_data.json", %{stock_data: stock_data}) do
    %{id: stock_data.id,
      code: stock_data.code,
      market_type: stock_data.market_type,
      name: stock_data.name,
      opening_price: stock_data.opening_price,
      max_price: stock_data.max_price,
      min_price: stock_data.min_price,
      avg_price: stock_data.avg_price,
      last_price: stock_data.last_price,
      best_buy: stock_data.best_buy,
      best_sell: stock_data.best_sell,
      trade_count: stock_data.trade_count,
      trade_amount: stock_data.trade_amount,
      date: stock_data.date}
  end
end
