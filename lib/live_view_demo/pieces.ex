defmodule Pieces do
  @moduledoc """
  Encapsulate the shape of each piece, initially in the player's rack
  then later on the board.
"""
  defstruct [:rack, :width, :height, :currently_selected, :on_board]
  
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
    rack_lines = @rack
      |> String.split(~r/\n/, trim: true)
      |> Enum.reject(fn line -> String.match?(line, ~r/\+-+\+/) end)
      |> Enum.map(fn line -> String.replace(line, ~r/^ *\|/, "") end)
      |> Enum.map(fn line -> String.replace(line, ~r/\|.*$/, "") end)
    raw_chars = rack_lines
      |> Enum.join
      |> String.split(~r//, trim: true)
    rack_squares = raw_chars
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({char, index}, acc) ->
          case {char, acc[char]} do
            {" ", _} -> acc
            {_, nil} -> put_in(acc, [char], [index])
            {_, value} -> put_in(acc, [char], [index | value])
          end
          end)
    height = Enum.count(rack_lines)
    width = Enum.count(raw_chars) / height

    %__MODULE__{
      width: width,
      height: height,
      rack: rack_squares,
      currently_selected: nil,
      on_board: %{}
    }
  end
end
