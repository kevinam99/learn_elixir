defmodule WordCount do
  def start(parsed, file, invalid) do
    if(invalid != [] or file === "h") do
      show_help()
    else
      read_file(parsed, file)
    end
  end

  def show_help() do
    IO.puts("""
    Usage: [filename] -[flags]
    Flags:
    -l    displays line count
    -w    displays word count
    -c    displays char count

    Multiple flags may be used.
    Example: somefile.txt -lc
    """)
  end

  filename = IO.gets("Enter the filename (h for help): ") |> String.trim()

  def read_file(parsed, filename) do
    flags =
      case Enum.count(parsed) do
        0 -> [:words]
        _ -> Enum.map(parsed, fn x -> elem(x, 0) end)
      end

      body = File.read!(filename)
      # some systems recognise \r as new line character too.
      lines = String.split(body, ~r{(\r\n|\n|\r)})

      words =
        String.split(body, ~r{(\\n|[^\w'])+})
        |> Enum.filter(fn x -> x != "" end)

      all_chars = String.split(body, "") |> Enum.filter(fn x -> x != "" end)
      Enum.each(flags, fn flag ->
        case flag do
          :words -> IO.puts("Word count: #{Enum.count(words)}")
          :lines -> IO.puts("Line count: #{Enum.count(lines)}")
          :chars -> IO.puts("Character count: #{Enum.count(all_chars)}")
          _ -> nil
        end
      end)
    end



  # else
  #   filename = "lib/" <> filename

  #   # creates a list
  #   parts = String.split(filename, "-")

  #   _some_comments = """
  #   Input is like: somefile.txt -lc
  #   parts will become as: ["somefile.txt ", "lc"]
  #   There's an extra space because the split was done on a hyphen
  #   to get the flags.

  #   Therefore, the filename will be the first element on the parts list
  #   which will have to be trimmed to get rid of that trailing space.
  #   """

  #   filename = List.first(parts) |> String.trim()
  #   # at this point, parts = ["somefile.txt ", "lc"], so flags are at index 1
  #   flags =
  #     case Enum.at(parts, 1) do
  #       # if no flags given, just count the words
  #       nil -> ["w"]
  #       chars -> String.split(chars, "") |> Enum.filter(fn x -> x != "" end)
  #     end


  #   # lines, words and all_chars are list of actual words from the file.
  #   # the count of each has to be given at the end

end
