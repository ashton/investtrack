defmodule InvesttrackWeb.ShareControllerTest do
  use InvesttrackWeb.ConnCase

  alias Investtrack.Stock

  @create_attrs %{code: "some code", name: "some name"}

  def fixture(:share) do
    {:ok, share} = Stock.create_share(@create_attrs)
    share
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all shares", %{conn: conn} do
      conn = get conn, share_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end
end
