defmodule D2t2.Trials do
  require Logger
  require Record
  
  Record.defrecord :acc, example: [], result_found: false
  
  def new_acc(example) do
    acc(example: example)
  end

  def reducer(x, acc) do
    alias D2t2.Quirk, as: Quirk

    example = acc(acc, :example)
    
    case Quirk.not_similar(x, example) do
      true -> {:cont, acc}
      false -> case Quirk.match(x, example) do
		 true -> {:halt, {:ok, Quirk.common_string(x, example)}}
		 false -> {:cont, acc}
	       end
    end
  end
end
