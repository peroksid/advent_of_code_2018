defmodule Advent.CLI do
  require Logger

  @solution_method :main

  def main(argv) do
    {parsed_switches, args, _} =
      OptionParser.parse(
        argv,
        switches: [verbose: :boolean]
      )

    switches = get_switches(parsed_switches)
    configure_logger(switches)
    process(args)
  end

  defp get_switches(switches) do
    default_switches = [verbose: false]

    Keyword.merge(
      default_switches,
      switches
    )
  end

  defp configure_logger(switches) do
    level =
      if Keyword.get(switches, :verbose) do
        :debug
      else
        :error
      end

    Logger.configure(level: level)
  end

  defp process([module_tag, input]) do
    apply(
      normalized_module(module_tag),
      @solution_method,
      [get_input_file_path(input)]
    )
  end

  defp process(_) do
    raise "advent [--verbose] <lower-cased task> <path to input>"
  end

  defp normalized_module(module_tag) do
    module_alias = String.capitalize(module_tag)
    module = Module.concat(["Advent", "Solutions", module_alias])
    Logger.debug(module)

    case Code.ensure_loaded(module) do
      {:module, module} -> module
      {:error, reason} -> raise "Can't load module #{module} for #{reason}"
    end

    unless function_exported?(module, @solution_method, 1) do
      raise "Public method #{module}:#{@solution_method}/1 does not exist"
    end

    module
  end

  defp get_input_file_path(provided_path) do
    path = Path.expand(provided_path)

    unless File.exists?(path) do
      raise "File does not exist: #{path}"
    end

    path
  end
end
