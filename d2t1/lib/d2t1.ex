defmodule D2t1 do
  import D2t1.State
  import D2t1.LetterCounterState
  require Logger
  
  def solve(path) do
    path
    |> File.read!()
    |> String.split()
    |> Enum.reduce(state(), &reduce_fun/2)
    |> (&(state(&1, :x2) * state(&1, :x3))).()
    |> IO.puts()
  end

  def reduce_fun(x, acc) do
    [count_of_2, count_of_3] =
      x
      |> String.to_charlist()
      |> Enum.reduce(letter_counter_state(), &reduce_letters/2)
      |> (&[letter_counter_state(&1, :count_of_2), letter_counter_state(&1, :count_of_3)]).()

    state(acc,
      x2: state(acc, :x2) + step_fun(count_of_2),
      x3: state(acc, :x3) + step_fun(count_of_3)
    )
  end

  def step_fun(0) do
    0
  end

  def step_fun(_) do
    1
  end
  
  def reduce_letters(x, acc) do
    letters_map = letter_counter_state(acc, :letters)
    x_count = Map.get(letters_map, x, 0) + 1

    count_of_2 = letter_counter_state(acc, :count_of_2)
    count_of_3 = letter_counter_state(acc, :count_of_3)

    [new_count_of_2, new_count_of_3] =
      case x_count do
        2 -> [count_of_2 + 1, count_of_3]
        3 -> [count_of_2 - 1, count_of_3 + 1]
        4 -> [count_of_2, count_of_3 - 1]
        _ -> [count_of_2, count_of_3]
      end

    letter_counter_state(acc,
      letters: Map.put(letters_map, x, x_count),
      count_of_2: new_count_of_2,
      count_of_3: new_count_of_3
    )
  end
end
