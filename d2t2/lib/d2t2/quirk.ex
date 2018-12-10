defmodule D2t2.Quirk do
  require Record
  Record.defrecord :quirk, l: 0, r: 0, o: 0, e: 0, s: MapSet.new()
  @type quirk :: record(:quirk, l: integer, r: integer, o: integer, e: integer, s: MapSet.t)

  def not_similar(a, b) do
    l(a) != l(b) && r(a) != r(b) && o(a) != o(b) && e(a) != e(b)
  end

  def match(a, b) do
    MapSet.size(MapSet.difference(s(a), s(b))) == 1
  end
  
  defp l(q) do quirk(q, :l) end
  defp r(q) do quirk(q, :r) end
  defp o(q) do quirk(q, :o) end
  defp e(q) do quirk(q, :e) end
  defp s(q) do quirk(q, :s) end
      
  @spec from_string(String.t) :: quirk
  def from_string(string) do
    string
    |> String.graphemes()
    |> Enum.reduce([0, String.length(string), quirk()], &from_string_reducer/2)
    |> (fn x -> Enum.at(x, 2) end).()
  end
  
  @spec from_string_reducer(String.grapheme, list()) :: list()
  def from_string_reducer(grapheme, [counter, length, q]) do
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

  def common_string(a, b) do
    MapSet.intersection(s(a), s(b))
    |> MapSet.to_list
    |> Enum.sort()
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.join()
  end
end
