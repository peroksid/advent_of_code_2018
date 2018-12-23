defmodule Advent.Solutions.D1t1 do
  use Advent.Day
  use Advent.LineParsers.Integer

  def solve(lines) do
    List.foldl(lines, 0, &(&1 + &2))
  end
end
