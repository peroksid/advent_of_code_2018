defmodule Advent.LineParsers.Integer do
  defmacro __using__(_opts) do
    quote do
      def parse_line(line) do
        {value, ""} = Integer.parse(line)
        value
      end
    end
  end
end
