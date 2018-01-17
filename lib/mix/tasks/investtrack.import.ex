defmodule Mix.Tasks.Investtrack.Import do
  use Mix.Task
  alias Investtrack.Price.Parsing

  @shortdoc "Import historical data from bovespa"

  @moduledoc """
  Task that will download and parse bovespa file with historical data,
  creating `Investrack.Price.Stock` structs for parsed data.
  """

  def run([path | _tail]) do
    test = %{avg_price: 17.06, best_buy: 17.02, best_sell: 17.09, code: "AALR3",
  date: ~N[2017-10-02 00:00:00], last_price: 17.04, market_type: "010",
  max_price: 17.28, min_price: 16.95, name: "ALLIAR", opening_price: 17.03,
  trade_amount: 272000, trade_count: 1115, trade_volume: 4641705.0}
    Investtrack.Price.create_stock(test)
    case File.read(path) do
      {:ok, body} ->
        body
        |> String.split("\r\n")
        |> Parsing.remove_header
        |> Parsing.remove_footer
        |> Parsing.parse_rows
        |> List.first
        |> Price.create_stock
        #|> Enum.each(&Price.create_stock/1)

        Mix.shell.info "File #{path} parsed successfully"
      {:error, reason} ->
        Mix.shell.error "Error reading file #{path}: #{reason}"
    end
  end
end