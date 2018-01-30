defmodule InvesttrackWeb.ShareController do
  use InvesttrackWeb, :controller

  alias Investtrack.Stock
  alias Investtrack.Stock.Share

  action_fallback InvesttrackWeb.FallbackController

  def index(conn, _params) do
    shares = Stock.list_shares()
    render(conn, "index.json", shares: shares)
  end

  def create(conn, %{"share" => share_params}) do
    with {:ok, %Share{} = share} <- Stock.create_share(share_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", share_path(conn, :show, share))
      |> render("show.json", share: share)
    end
  end

  def show(conn, %{"id" => id}) do
    share = Stock.get_share!(id)
    render(conn, "show.json", share: share)
  end

  def update(conn, %{"id" => id, "share" => share_params}) do
    share = Stock.get_share!(id)

    with {:ok, %Share{} = share} <- Stock.update_share(share, share_params) do
      render(conn, "show.json", share: share)
    end
  end

  def delete(conn, %{"id" => id}) do
    share = Stock.get_share!(id)
    with {:ok, %Share{}} <- Stock.delete_share(share) do
      send_resp(conn, :no_content, "")
    end
  end
end
