defmodule PentominoGame do
  @moduledoc """
  Manage one pentomino game.
"""

  defstruct [:id, :players, :game_board]

  def new() do
    %__MODULE__{
      id: :rand.uniform(987654), # TODO: a better ID, such as one from Ecto
      players: [],
      game_board: []
    }
  end
  
  def needs_player?(%PentominoGame{}) do
    IO.puts "method: show_game"
    false
  end

end
