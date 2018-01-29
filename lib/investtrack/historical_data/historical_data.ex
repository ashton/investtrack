defmodule Investtrack.HistoricalData do
  @moduledoc """
  The HistoricalData context.
  """

  import Ecto.Query, warn: false
  alias Investtrack.Repo

  alias Investtrack.HistoricalData.StockData

  @doc """
  Returns the list of stock_historical_data.

  ## Examples

      iex> list_stock_historical_data()
      [%StockData{}, ...]

  """
  def list_stock_historical_data do
    Repo.all(StockData)
  end

  @doc """
  Gets a single stock_data.

  Raises `Ecto.NoResultsError` if the Stock data does not exist.

  ## Examples

      iex> get_stock_data!(123)
      %StockData{}

      iex> get_stock_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock_data!(id), do: Repo.get!(StockData, id)

  @doc """
  Creates a stock_data.

  ## Examples

      iex> create_stock_data(%{field: value})
      {:ok, %StockData{}}

      iex> create_stock_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock_data(attrs \\ %{}) do
    %StockData{}
    |> StockData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock_data.

  ## Examples

      iex> update_stock_data(stock_data, %{field: new_value})
      {:ok, %StockData{}}

      iex> update_stock_data(stock_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock_data(%StockData{} = stock_data, attrs) do
    stock_data
    |> StockData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StockData.

  ## Examples

      iex> delete_stock_data(stock_data)
      {:ok, %StockData{}}

      iex> delete_stock_data(stock_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock_data(%StockData{} = stock_data) do
    Repo.delete(stock_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock_data changes.

  ## Examples

      iex> change_stock_data(stock_data)
      %Ecto.Changeset{source: %StockData{}}

  """
  def change_stock_data(%StockData{} = stock_data) do
    StockData.changeset(stock_data, %{})
  end
end
