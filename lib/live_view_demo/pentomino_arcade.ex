defmodule PentominoArcade do
  @moduledoc """
  Manage all the pentomino games.
"""

  defstruct [:games]

  def new() do
    %__MODULE__{
      games: []
    }
  end
  
  def needs_player?(%__MODULE__{}) do
    IO.puts "method: needs_player"
  end

  def call_to_action(%__MODULE__{games: games}) do
    IO.puts "method: call_to_action"
    Enum.random(["Start Game", "Join Game"])
  end

  def start_or_join_game(%__MODULE__{games: games}) do
    IO.puts "method: start_or_join_game/1"
    Enum.find(games, fn game -> PentominoGame.needs_player?(game) end, PentominoGame.new)
  end
  def start_or_join_game(%__MODULE__{games: games}) do
    IO.puts "method: start_or_join_game/2"
    Enum.find(games, fn game -> PentominoGame.needs_player?(game) end, PentominoGame.new)
  end

  def show_game(%PentominoGame{}) do
    IO.puts "method: show_game"
  end
  
  def current_games(%__MODULE__{games: games}) do
    IO.puts "method: current_games"
    games
  end
end
