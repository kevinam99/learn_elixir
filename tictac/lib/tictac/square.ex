defmodule Tictac.Square do
  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @board_size 1..3
  def new(col, row) when col in @board_size and row in @board_size do
    {:ok, %Square{row: row, col: col}}
  end

  def new(_, _), do: {:error, :invalid_square}

  def new_board do
    for set <- squares(), into: %{}, do: {set, :empty}
    # %{
    #   %Square{col: 1, row: 1} => :empty,
    #   %Square{col: 1, row: 2} => :empty,
    #   %Square{col: 1, row: 3} => :empty,
    #   %Square{col: 2, row: 1} => :empty,
    #   %Square{col: 2, row: 2} => :empty,
    #   %Square{col: 2, row: 3} => :empty,
    #   %Square{col: 3, row: 1} => :empty,
    #   %Square{col: 3, row: 2} => :empty,
    #   %Square{col: 3, row: 3} => :empty
    # }

  end
  defp squares do
    # MapSet ensures that each (row, col) value is unique, i.e, implement a set on a map
    for col <- @board_size, row <- @board_size, into: MapSet.new(), do: %Square{row: row, col: col}
  end
end
