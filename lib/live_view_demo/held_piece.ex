defmodule HeldPiece do
  @moduledoc """
  A piece that a player has picked up.
"""

  defstruct [:player_id, :color, :piece_id, :rack_positions, :board_positions]

  def new(player_id, color, piece_id, rack_positions) do
    %__MODULE__{
      player_id: player_id,
      color: color,
      piece_id: piece_id,
      rack_positions: rack_positions,
      board_positions: rack_positions
    }
  end
  

end
