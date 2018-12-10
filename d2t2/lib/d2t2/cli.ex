defmodule D2t2.CLI do
  def main(argv) do
    argv
    |> parse_argv
    |> process
  end

  def parse_argv(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _} -> :help
      {_, [path], _} -> {:path_to_input, path}
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts("""
    usage: d2t2 <path to input>
    """)

    System.halt(0)
  end

  def process({:path_to_input, path}) do
    Logger.configure(level: :debug)
    D2t2.solve(path)
  end
end
