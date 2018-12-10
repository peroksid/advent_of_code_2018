defmodule D2t2 do
  require Logger
  
  def solve(path) do
    alias D2t2.Quirk, as: Quirk
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&Quirk.from_string/1)
    |> find_answer()
    |> IO.puts()
  end

  def find_answer([h | t]) do
    find_answer_recur(h, t, :deep)
  end

  def find_answer_recur(example, trials, :deep) do
    alias D2t2.Trials, as: Trials
    
    result = Enum.reduce_while(trials, Trials.new_acc(example), &Trials.reducer/2)
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
end
