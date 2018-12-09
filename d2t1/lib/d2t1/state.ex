defmodule D2t1.State do
  require Record
  Record.defrecord(:state, x2: 0, x3: 0)

  @type state :: record(:state, x2: integer, x3: integer)
end
