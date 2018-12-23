defmodule Advent.Solutions.D1t2 do
  use Advent.Day
  use Advent.LineParsers.Integer

  require Record

  Record.defrecord(
    :state, value: 0,
    frequencies: MapSet.new(),
    halted: false)
  
  @type state :: record(:state,
    value: integer,
    frequencies: MapSet.t(),
    halted: boolean)
  
  def solve(lines) do
    find_answer(lines, false, state())
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
