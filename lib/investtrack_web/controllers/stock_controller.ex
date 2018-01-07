defmodule InvesttrackWeb.StockController do
  use InvesttrackWeb, :controller

  alias Investtrack.Price
  alias Investtrack.Price.Stock

  action_fallback InvesttrackWeb.FallbackController

  def index(conn, _params) do
    stock_prices = Price.list_stock_prices()
    render(conn, "index.json", stock_prices: stock_prices)
  end

  def create(conn, %{"stock" => stock_params}) do
    with {:ok, %Stock{} = stock} <- Price.create_stock(stock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", stock_path(conn, :show, stock))
      |> render("show.json", stock: stock)
    end
  end

  def show(conn, %{"id" => id}) do
    stock = Price.get_stock!(id)
    render(conn, "show.json", stock: stock)
  end

  def update(conn, %{"id" => id, "stock" => stock_params}) do
    stock = Price.get_stock!(id)

    with {:ok, %Stock{} = stock} <- Price.update_stock(stock, stock_params) do
      render(conn, "show.json", stock: stock)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock = Price.get_stock!(id)
    with {:ok, %Stock{}} <- Price.delete_stock(stock) do
      send_resp(conn, :no_content, "")
    end
  end
end
