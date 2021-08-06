filename = IO.gets("File to count words: ") |> String.trim()
filename = "lib/" <> filename
IO.puts(filename)

body =
  File.read!(filename)
  |> String.trim()
  |> String.split(~r{\\n|([^\w'])+})
  |> Enum.map(fn x -> x != " " or x != "_" end)

IO.puts("There are #{Enum.count(body)} words in #{filename}")
IO.inspect(body)

File.stream!(filename)
|> Stream.map(&String.trim/1)
|> Stream.with_index()
|> Stream.map(fn {line, index} -> IO.puts("#{index + 1} #{line}") end)
|> Stream.run()
