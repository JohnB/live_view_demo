defmodule PentominoGame do
  @moduledoc """
  Manage one pentomino game.
"""

  defstruct [:id, :players, :board]

  def new(player_id) do
    %__MODULE__{
      id: "#{:rand.uniform(999999)}", # TODO: a better ID, such as one from Ecto
      players: [player_id],
      board: Board.new()
    }
  end
  
  def add_player(state = %PentominoGame{players: players}, player_id) do
    %{state | players: players ++ [player_id]}
  end
  
  def needs_player?(%PentominoGame{players: players}) do
    Enum.count(players) < 4
  end

end
