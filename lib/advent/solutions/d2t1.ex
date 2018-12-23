defmodule Advent.Solutions.D2t1 do
  use Advent.Day
  require Record

  Record.defrecord(
    :letter_counter_state,
    letters: %{},
    count_of_2: 0,
    count_of_3: 0
  )

  @type letter_counter_state ::
          record(
            :letter_counter_state,
            letters: Map.t(),
            count_of_2: integer,
            count_of_3: integer
          )

  defp count_of_2(letter_counter) do
    letter_counter_state(letter_counter, :count_of_2)
  end

  defp count_of_3(letter_counter) do
    letter_counter_state(letter_counter, :count_of_3)
  end

  defp reduce_letters(x, acc) do
    letters_map = letter_counter_state(acc, :letters)
    x_count = Map.get(letters_map, x, 0) + 1

    count_of_2 = count_of_2(acc)
    count_of_3 = count_of_3(acc)

    [new_count_of_2, new_count_of_3] =
      case x_count do
        2 -> [count_of_2 + 1, count_of_3]
        3 -> [count_of_2 - 1, count_of_3 + 1]
        4 -> [count_of_2, count_of_3 - 1]
        _ -> [count_of_2, count_of_3]
      end

    letter_counter_state(
      acc,
      letters: Map.put(letters_map, x, x_count),
      count_of_2: new_count_of_2,
      count_of_3: new_count_of_3
    )
  end

  defp step_fun(x) do
    case x do
      0 -> 0
      _ -> 1
    end
  end

  def parse_line(line) do
    line
    |> String.to_charlist()
    |> Enum.reduce(letter_counter_state(), &reduce_letters/2)
    |> (&{step_fun(count_of_2(&1)), step_fun(count_of_3(&1))}).()
  end

  def solve(lines) do
    lines
    |> Enum.unzip()
    |> (fn {a, b} -> Enum.sum(a) * Enum.sum(b) end).()
  end
end
