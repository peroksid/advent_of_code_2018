defmodule Advent.Solutions.D3t1 do
  use Advent.Day

  def parse_line(line) do
    {value, ""} = Integer.parse(line)
    value
  end
  
  def solve(_) do
    IO.puts("hoh")
  end
end
