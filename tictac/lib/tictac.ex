defmodule Tictac do
  alias Tictac.Square
  @players {:x, :o}

  def check_player(player) do
    case player do
      :x -> {:ok, player}
      :o -> {:ok, player}
      _ -> {:error, :invalid_player}
    end
  end

  def place_piece(board, place, player) do
    case board[place] do
      nil -> {:error, :invalid_location}
      :x -> {:error, :x_occupied}
      :o -> {:error, :o_occupied}
      :empty -> {:ok, %{board | place => player}}
    end
  end

  def play_at(board, row, col, player) do
    with {:ok, valid_player} <- check_player(player),
        {:ok, location} <- Square.new(row, col), # returns the place where the piece has to be played
        {:ok, new_board} <- place_piece(board, location, valid_player),
      do: new_board
  end

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
  def squares do
    # MapSet ensures that each (row, col) value is unique, i.e, implement a set on a map
    for col <- 1..3, row <- 1..3, into: MapSet.new(), do: %Square{row: row, col: col}
  end
end
