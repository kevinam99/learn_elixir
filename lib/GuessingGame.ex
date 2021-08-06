defmodule GuessingGame do
  # guess between a low number and a high number -> guess middle number
  # tell user our guess
  # if user says "yes" -> game over
  # "bigger" -> bigger(low, high)
  # "smaller" -> smaller(low, high)
  # anything else -> tell user to enter valid response

  def mid(low, high) do
    div(low + high, 2)
  end

  def bigger(low, high) do
    new_low = min(mid(low, high) + 1, high)
    guess(new_low, high)
  end

  def smaller(low, high) do
    new_max = max(low, mid(low, high) - 1)
    guess(low, new_max)
  end

  def guess(a, b) when a > b do
    guess(b, a)
  end

  def guess(low, high) do
    # IO.puts low
    # IO.puts high

    _guess_num = mid(low, high) |> IO.puts()

    is_right =
      IO.gets("Am I right? Enter yes, bigger or smaller: ") |> String.trim() |> String.downcase()

    case is_right do
      "yes" ->
        IO.puts("game over")
        :ok

      "bigger" ->
        bigger(low, high)

      "smaller" ->
        smaller(low, high)

      _ ->
        IO.puts("Enter a valid input")
        :error
    end
  end
end
