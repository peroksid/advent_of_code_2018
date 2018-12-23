defmodule Advent.Day do
  defmacro __using__(_opts) do
    quote do
      @behaviour Advent.Day.Behaviour

      def main(path) do
	IO.puts(path)
      end
    end
  end
end
