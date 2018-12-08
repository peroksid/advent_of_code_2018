defmodule D1t2.State do
  require Record

  Record.defrecord(:state, value: 0, frequencies: MapSet.new(), halted: false)
  @type state :: record(:state, value: integer, frequencies: MapSet.t(), halted: boolean)
end
