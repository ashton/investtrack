defmodule Mix.Tasks.Investtrack.Import do
  use Mix.Task
  import Mix.Ecto
  alias Investtrack.Stock
  alias Investtrack.HistoricalData
  alias Investtrack.HistoricalData.Parsing

  @shortdoc "Import historical data from bovespa"

  @moduledoc """
  Task that will download and parse bovespa file with historical data,
  creating `Investrack.Price.Stock` structs for parsed data.
  """

  def run([path | _tail]) do
    ensure_started(Investtrack.Repo, [])

    File.stream!(path)
    |> Stream.drop(1)  # remove header
    |> Stream.drop(-1) # remove footer
    |> Stream.map(&Parsing.parse_row/1)
    |> Stream.map(&HistoricalData.create_stock_data/1)
    |> Stream.map(fn {:ok, historical_data} -> Map.take(historical_data, [:name, :code]) end)
    |> Stream.uniq
    |> Stream.map(&Stock.create_share/1)
    |> Stream.run
  end
end