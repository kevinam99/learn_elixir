defmodule Square do
  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  def new(col, row) when col in 1..3 and row in 1..3 do
    {:ok, %Square{row: row, col: col}}
  end

  def new(_, _), do: {:error, :inavlid_square}
end
