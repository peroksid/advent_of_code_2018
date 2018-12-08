defmodule D1t2 do
  import D1t2.State
  require Logger

  def read_integer_lines(path) do
    result =
      path
      |> File.read!()
      |> String.split()
      |> Enum.map(fn x ->
        {value, ""} = Integer.parse(x)
        value
      end)

    result
  end

  def solve(path) do
    path
    |> read_integer_lines()
    |> find_answer(false, state())
    |> IO.puts
  end

  def find_answer(lines, false, acc) do
    new_acc = Enum.reduce_while(lines, acc, &reduce_fun/2)
    find_answer(lines, state(new_acc, :halted), new_acc)
  end

  def find_answer(_lines, true, acc) do
    state(acc, :value)
  end
    
  def reduce_fun(x, acc) do
    new_value = state(acc, :value) + x
    
    case MapSet.member?(state(acc, :frequencies), new_value) do
      true ->
        Logger.debug("true test")
	new_state = state(acc, value: new_value, halted: true)
        {:halt, new_state}

      false ->
        Logger.debug("false test")

        {:cont,
         state(acc,
           value: new_value,
           frequencies: MapSet.put(state(acc, :frequencies), new_value)
         )}
    end
  end
end
