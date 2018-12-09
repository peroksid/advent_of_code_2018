defmodule D2t1.LetterCounterState do
  require Record
  Record.defrecord(:letter_counter_state, letters: %{}, count_of_2: 0, count_of_3: 0)

  @type letter_counter_state ::
          record(:letter_counter_state, letters: Map.t(), count_of_2: integer, count_of_3: integer)
end
