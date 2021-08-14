defmodule Tictac.State do
  alias Tictac.{Square, State}
  @players [:x, :o]

  # statuses are :initial, choose_p1, playing, fame_over, winner_reported

  defstruct status: :initial,
            turn: nil,
            winner: nil,
            board: Square.new_board(),
            ui: nil

  def new(), do: {:ok, %State{}}
  def new(ui), do: {:ok, %State{ui: ui}}

  def event(%State{status: :initial} = state, {:choose_p1, player}) do
    case Tictac.check_player(player) do
      {:ok, player} -> {:ok, %State{state | status: :playing, turn: player}}
      _ -> {:error, :invalid_player}
    end
  end

  def event(%State{status: :playing}, {:play, p}) when p not in @players do
    {:error, :invalid_player}
  end

  def event(%State{status: :playing,  turn: p} = state, {:play, p}) do
    {:ok, %State{state| turn: other_player(p)}}
  end

  def event(%State{status: :playing}, {:play, _}), do: {:error, :out_of_turn}

  def event(%State{status: playing} = state, {:check_for_winner, winner}) do
    case winner do
      true -> {:ok, %State{state | status: :game_over, winner: winner}}
      _ -> {:error, :invalid_player}
    end
  end

  def event(%State{status: :playing} = state, {:game_over?, over_or_not}) do
    case over_or_not do
      :not_over -> {:ok, state}
      :game_over -> {:ok, %State{state | status: :game_over, winner: :tie}}
      _ -> {:error, :invalid_game_status}
    end
  end

  def evet(_state, _action) do
    {:error, {:invalid_state_transition,%{state: state, action: action}}}
  end

  def other_player(player) do
    case player do
      :x -> :o
      :o -> :x
      _ -> {:error, :invalid_player}
    end
  end
end
