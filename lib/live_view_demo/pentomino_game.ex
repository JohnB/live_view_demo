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

  def pick_up_piece(game_id, player_id, piece_id, rack_squares) do
    # Find the game in the arcade
    # Build a held_piece struct with player's color, piece_on_5x5_grid, etc.
    # Pick a random board location
    # move_held_piece_to(location)
  end

  def move_held_piece_to(game_id, location) do
    # Find the game in the arcade
    # Translate the grid to the location
    # Fix the board code to show the held picee
    # Fix the code to show _all_ held picees
  end

  def vertical_flip_held_piece(game_id, player_id) do
    # Find the game in the arcade
    # flip the 5x5 grid
  end

  def horizontal_flip_held_piece(game_id, player_id) do
    # Find the game in the arcade
    # flip the 5x5 grid
  end

  def rotate_right_held_piece(game_id, player_id) do
    # Find the game in the arcade
    # rotate R the 5x5 grid
  end

  def rotate_left_held_piece(game_id, player_id) do
    # Find the game in the arcade
    # rotate RRR the 5x5 grid
  end

  def place_held_piece(game_id, player_id) do
    # Find the game in the arcade
    # or should it be "Game.finish_the_move"?
  end

  def finish_move(game_id, player_id) do
    # Find the game in the arcade
    # permanently place the held piece on the board (or, at least in the list of moves that get displayed on the board)
  end

end
