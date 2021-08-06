defmodule NameGuess do
  def getname(name \\ "kevin") do
    # name = IO.gets("What's your name? ") |> String.trim()

    case name do
      "kevin" ->
        IO.puts("Special message for Kevin")
        :ok

      _ ->
        IO.puts("Hello #{name}!")
        :ok
    end
  end
end

# NameGuess.getname()
