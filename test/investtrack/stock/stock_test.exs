defmodule Investtrack.StockTest do
  use Investtrack.DataCase

  alias Investtrack.Stock

  describe "shares" do
    alias Investtrack.Stock.Share

    @valid_attrs %{code: "some code", name: "some name"}
    @update_attrs %{code: "some updated code", name: "some updated name"}
    @invalid_attrs %{code: nil, name: nil}

    def share_fixture(attrs \\ %{}) do
      {:ok, share} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stock.create_share()

      share
    end

    test "list_shares/0 returns all shares" do
      share = share_fixture()
      assert Stock.list_shares() == [share]
    end

    test "get_share!/1 returns the share with given id" do
      share = share_fixture()
      assert Stock.get_share!(share.id) == share
    end

    test "create_share/1 with valid data creates a share" do
      assert {:ok, %Share{} = share} = Stock.create_share(@valid_attrs)
      assert share.code == "some code"
      assert share.name == "some name"
    end

    test "create_share/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stock.create_share(@invalid_attrs)
    end

    test "update_share/2 with valid data updates the share" do
      share = share_fixture()
      assert {:ok, share} = Stock.update_share(share, @update_attrs)
      assert %Share{} = share
      assert share.code == "some updated code"
      assert share.name == "some updated name"
    end

    test "update_share/2 with invalid data returns error changeset" do
      share = share_fixture()
      assert {:error, %Ecto.Changeset{}} = Stock.update_share(share, @invalid_attrs)
      assert share == Stock.get_share!(share.id)
    end

    test "delete_share/1 deletes the share" do
      share = share_fixture()
      assert {:ok, %Share{}} = Stock.delete_share(share)
      assert_raise Ecto.NoResultsError, fn -> Stock.get_share!(share.id) end
    end

    test "change_share/1 returns a share changeset" do
      share = share_fixture()
      assert %Ecto.Changeset{} = Stock.change_share(share)
    end
  end
end
