defmodule D1t1 do
  def solve(path) do
    IO.puts("Called with #{path}")

    result =
      path
      |> File.read!()
      |> String.split()
      |> Enum.map(fn x ->
        {value, ""} = Integer.parse(x)
        value
      end)
      |> List.foldl(0, fn x, acc -> acc + x end)

    IO.puts(result)
  end
end
