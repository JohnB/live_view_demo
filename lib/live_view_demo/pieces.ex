defmodule Pieces do
  @moduledoc """
  Encapsulate the shape of each piece, initially in the player's rack
  then later on the board.
"""
  defstruct [:rack_squares, :width, :height, :currently_selected]
  
  @rack """
    +-------------+
    |             |
    | 1 22 333 44 |
    |           4 |
    | 5555 666    |
    |      6   88 |
    | 777      88 |
    |  7  LLLL    |
    |     L    NN |
    | 99     NNN  |
    |  99 PP      |
    |     PPP VVV |
    | UUU       V |
    | U U IIIII V |
    |             |
    |  FF TTT  W  |
    | FF   T  WW  |
    |  F   T WW   |
    |    X      Z |
    | Y XXX   ZZZ |
    | Y  X    Z   |
    | YY          |
    | Y           |
    |             |
    +-------------+
"""

  def new() do
    %__MODULE__{
      currently_selected: nil,
      width: 123,
      height: 234,
      rack_squares: %{}
    }
  end
end
