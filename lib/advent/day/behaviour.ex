defmodule Advent.Day.Behaviour do
  @callback parse_line(String.t) :: term
  @callback solve(List) :: String.t

  def main(path) do
    IO.puts(path)
    # |> File.read!()
    # |> String.split()
    # |> Enum.map(&(parse_line(&1)))
    # |> (&solve(&1)).()
    # |> IO.puts()
  end
end
