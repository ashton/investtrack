defmodule InvesttrackWeb.ShareControllerTest do
  use InvesttrackWeb.ConnCase

  alias Investtrack.Stock
  alias Investtrack.Stock.Share

  @create_attrs %{code: "some code", name: "some name"}
  @update_attrs %{code: "some updated code", name: "some updated name"}
  @invalid_attrs %{code: nil, name: nil}

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

  describe "create share" do
    test "renders share when data is valid", %{conn: conn} do
      conn = post conn, share_path(conn, :create), share: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, share_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "code" => "some code",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, share_path(conn, :create), share: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update share" do
    setup [:create_share]

    test "renders share when data is valid", %{conn: conn, share: %Share{id: id} = share} do
      conn = put conn, share_path(conn, :update, share), share: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, share_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "code" => "some updated code",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, share: share} do
      conn = put conn, share_path(conn, :update, share), share: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete share" do
    setup [:create_share]

    test "deletes chosen share", %{conn: conn, share: share} do
      conn = delete conn, share_path(conn, :delete, share)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, share_path(conn, :show, share)
      end
    end
  end

  defp create_share(_) do
    share = fixture(:share)
    {:ok, share: share}
  end
end
