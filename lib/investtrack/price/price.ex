defmodule Investtrack.Price do
  @moduledoc """
  The Price context.
  """

  import Ecto.Query, warn: false
  alias Investtrack.Repo

  alias Investtrack.Price.Stock

  @doc """
  Returns the list of stock_prices.

  ## Examples

      iex> list_stock_prices()
      [%Stock{}, ...]

  """
  def list_stock_prices do
    Repo.all(Stock)
  end

  @doc """
  Gets a single stock.

  Raises `Ecto.NoResultsError` if the Stock does not exist.

  ## Examples

      iex> get_stock!(123)
      %Stock{}

      iex> get_stock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock!(id), do: Repo.get!(Stock, id)

  @doc """
  Creates a stock.

  ## Examples

      iex> create_stock(%{field: value})
      {:ok, %Stock{}}

      iex> create_stock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock(attrs \\ %{}) do
    IO.inspect(attrs)
    %Stock{}
    |> Stock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock.

  ## Examples

      iex> update_stock(stock, %{field: new_value})
      {:ok, %Stock{}}

      iex> update_stock(stock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock(%Stock{} = stock, attrs) do
    stock
    |> Stock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Stock.

  ## Examples

      iex> delete_stock(stock)
      {:ok, %Stock{}}

      iex> delete_stock(stock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock(%Stock{} = stock) do
    Repo.delete(stock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock changes.

  ## Examples

      iex> change_stock(stock)
      %Ecto.Changeset{source: %Stock{}}

  """
  def change_stock(%Stock{} = stock) do
    Stock.changeset(stock, %{})
  end
end
