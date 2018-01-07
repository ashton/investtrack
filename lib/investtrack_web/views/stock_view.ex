defmodule InvesttrackWeb.StockView do
  use InvesttrackWeb, :view
  alias InvesttrackWeb.StockView

  def render("index.json", %{stock_prices: stock_prices}) do
    %{data: render_many(stock_prices, StockView, "stock.json")}
  end

  def render("show.json", %{stock: stock}) do
    %{data: render_one(stock, StockView, "stock.json")}
  end

  def render("stock.json", %{stock: stock}) do
    %{id: stock.id,
      code: stock.code,
      market_type: stock.market_type,
      name: stock.name,
      opening_price: stock.opening_price,
      max_price: stock.max_price,
      min_price: stock.min_price,
      avg_price: stock.avg_price,
      last_price: stock.last_price,
      best_buy: stock.best_buy,
      best_sell: stock.best_sell,
      trade_count: stock.trade_count,
      trade_amount: stock.trade_amount,
      date: stock.date}
  end
end
