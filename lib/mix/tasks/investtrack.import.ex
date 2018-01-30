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

    case File.read(path) do
      {:ok, body} ->
        body
        |> String.split("\r\n")
        |> Parsing.remove_header
        |> Parsing.remove_footer
        |> Parsing.parse_rows
        |> Enum.map(&HistoricalData.create_stock_data/1)
        |> Enum.map(fn {:ok, historical_data} -> Map.take(historical_data, [:name, :code]) end)
        |> Enum.into(MapSet.new)
        |> Enum.map(&Stock.create_share/1) 

        Mix.shell.info "File #{path} parsed successfully"
      {:error, reason} ->
        Mix.shell.error "Error reading file #{path}: #{reason}"
    end
  end
end