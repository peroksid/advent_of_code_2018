defmodule Advent.Solutions.D3t1 do
  use Advent.Day

  def parse_line(line) do
    ~r/^#\d+ @ (\d+),(\d+): (\d+)x(\d+)$/
    |> Regex.run(line)
    |> (fn [_ | t] -> t end).()
    |> Enum.map(fn x ->
      {value, ""} = Integer.parse(x)
      value
    end)
    |> (fn [x, y, dx, dy] -> {(x + 1)..(x + dx), (y + 1)..(y + dy)} end).()
    |> to_map()
  end

  def solve(lines) do
    lines
    |> Enum.reduce(Map.new(), fn m, acc ->
      Map.merge(acc, m, fn _k, v1, v2 -> v1 + v2 end)
    end)
    |> Map.to_list()
    |> Enum.count(fn {_, x} -> x >= 2 end)
  end

  @spec to_map({Range.t(), Range.t()}) :: map()
  defp to_map({xrange, yrange}) do
    Enum.reduce(
      xrange,
      Map.new(),
      fn x, map ->
        row_map =
          Enum.reduce(yrange, map, fn y, map1 ->
            Map.put_new(map1, {x, y}, 1)
          end)

        Logger.debug(row_map)
        Map.merge(map, row_map)
      end
    )
  end
end
