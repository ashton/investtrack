defmodule Mix.Tasks.Investtrack.Import do
  use Mix.Task
  alias Investtrack.Price
  alias Investtrack.Price.Parsing

  @shortdoc "Import historical data from bovespa"

  @moduledoc """
  Task that will download and parse bovespa file with historical data,
  creating `Investrack.Price.Stock` structs for parsed data.
  """

  def run([path | _tail]) do
    case File.read(path) do
      {:ok, body} ->
        body
        |> String.split("\r\n")
        |> Parsing.remove_header
        |> Parsing.remove_footer
        |> Parsing.parse_rows
        |> List.first
        |> IO.inspect
        #|> Enum.each(&Price.create_stock/1)

        Mix.shell.info "File #{path} parsed successfully"
      {:error, reason} ->
        Mix.shell.error "Error reading file: #{reason}"
    end
  end
end