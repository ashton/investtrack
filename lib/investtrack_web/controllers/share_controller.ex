defmodule InvesttrackWeb.ShareController do
  use InvesttrackWeb, :controller

  alias Investtrack.Stock
  alias Investtrack.Stock.Share

  action_fallback InvesttrackWeb.FallbackController

  def index(conn, _params) do
    shares = Stock.list_shares()
    render(conn, "index.json", shares: shares)
  end

  def show(conn, %{"id" => id}) do
    share = Stock.get_share!(id)
    render(conn, "show.json", share: share)
  end
end
