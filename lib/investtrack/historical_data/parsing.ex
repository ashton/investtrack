defmodule Investtrack.HistoricalData.Parsing do
  def get_rules() do
    [%{id: :date, start_pos: 2, end_pos: 9, formatter: :date},
   %{id: :code, start_pos: 12, end_pos: 23, formatter: :text},
   %{id: :market_type, start_pos: 24, end_pos: 26, formatter: :text},
   %{id: :name, start_pos: 27, end_pos: 38, formatter: :text},
   %{id: :opening_price, start_pos: 56, end_pos: 68, formatter: :float},
   %{id: :max_price, start_pos: 69, end_pos: 81, formatter: :float},
   %{id: :min_price, start_pos: 82, end_pos: 94, formatter: :float},
   %{id: :avg_price, start_pos: 95, end_pos: 107, formatter: :float},
   %{id: :last_price, start_pos: 108, end_pos: 120, formatter: :float},
   %{id: :best_buy, start_pos: 121, end_pos: 133, formatter: :float},
   %{id: :best_sell, start_pos: 134, end_pos: 146, formatter: :float},
   %{id: :trade_count, start_pos: 147, end_pos: 151, formatter: :integer},
   %{id: :trade_amount, start_pos: 152, end_pos: 169, formatter: :integer},
   %{id: :trade_volume, start_pos: 170, end_pos: 187, formatter: :float}]
  end

  def parse(value, target) do
    case target do
      :integer -> String.to_integer(value)
      :text -> String.trim(value)
      :float -> 
        len = String.length(value)
        "#{String.slice(value, 0..len-3)}.#{String.slice(value, len-2..len-1)}"
        |> String.to_float
      :date ->
        {:ok, date} = Timex.parse(value, "{YYYY}{0M}{0D}")
        date
    end
  end

  def parse_row(row) do
    Enum.reduce get_rules(), %{}, fn(rule, acc) ->
      Map.put(acc, rule.id, extract_segment(row, rule))
    end
  end

  def extract_segment(text, %{start_pos: start_pos, end_pos: end_pos, formatter: target}) do
    text
    |> String.slice(start_pos..end_pos)
    |> parse(target)
  end
end