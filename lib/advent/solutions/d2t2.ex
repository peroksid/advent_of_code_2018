defmodule Advent.Solutions.D2t2 do
  use Advent.Day

  require Record
  Record.defrecord :quirk, l: 0, r: 0, o: 0, e: 0, s: MapSet.new()
  @type quirk :: record(:quirk, l: integer, r: integer, o: integer, e: integer, s: MapSet.t)

  defp not_similar(a, b) do
    l(a) != l(b) && r(a) != r(b) && o(a) != o(b) && e(a) != e(b)
  end

  defp match(a, b) do
    MapSet.size(MapSet.difference(s(a), s(b))) == 1
  end

  defp l(q) do quirk(q, :l) end
  defp r(q) do quirk(q, :r) end
  defp o(q) do quirk(q, :o) end
  defp e(q) do quirk(q, :e) end
  defp s(q) do quirk(q, :s) end

  @spec from_string_reducer(String.grapheme, list()) :: list()
  defp from_string_reducer(grapheme, [counter, length, q]) do
    <<x::utf8>> = grapheme
    [l, r] = case div(counter, length) do
               1 -> [l(q), r(q) + x]
               _ -> [l(q) + x, r(q)]
             end
    [o, e] = case rem(counter, 2) do
               0 -> [o(q), e(q) + x]
	       1 -> [o(q) + x, e(q)]
               end
    s = MapSet.put(s(q), {counter, grapheme})
    [counter + 1, length, quirk(l: l, r: r, o: o, e: e, s: s)]
  end

  defp common_string(a, b) do
    MapSet.intersection(s(a), s(b))
    |> MapSet.to_list
    |> Enum.sort()
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.join()
  end

  def parse_line(line) do
    line
    |> String.graphemes()
    |> Enum.reduce([0, String.length(line), quirk()], &from_string_reducer/2)
    |> (fn x -> Enum.at(x, 2) end).()
  end
  
  def solve([h | t]) do
    find_answer_recur(h, t, :deep)
  end

  def find_answer_recur(example, trials, :deep) do
    result = Enum.reduce_while(trials, new_acc(example), &reducer/2)
    [next_example, next_trials, answer] = case result do
                                            {:ok, answer} -> ["", [], answer]
                                            _ ->
                                              [h|t] = trials
                                              [h, t, :deep]
                                          end
    find_answer_recur(next_example, next_trials, answer)
  end

  def find_answer_recur(_, _, answer) do
    answer
  end

  def find_answer_recur(_, []) do
    raise "We should have find an answer by the moment"
  end

  Record.defrecord :acc, example: [], result_found: false

  defp new_acc(example) do
    acc(example: example)
  end

  defp reducer(x, acc) do
    example = acc(acc, :example)

    case not_similar(x, example) do
      true -> {:cont, acc}
      false -> case match(x, example) do
                 true -> {:halt, {:ok, common_string(x, example)}}
                 false -> {:cont, acc}
               end
    end
  end
end
