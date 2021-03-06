defmodule Advent.Day do
  defmacro __using__(_opts) do
    quote do
      require Logger
      @behaviour Advent.Day.Behaviour

      def main(path) do
        path
        |> File.read!()
        |> String.split("\n", trim: true)
        |> Enum.map(&parse_line/1)
        |> (&solve/1).()
        |> IO.puts()
      end
    end
  end
end
