defmodule TileRack do
  @moduledoc """
  Encapsulate the shape of each piece, initially in the player's rack
  then later on the board.
"""
  defstruct [:rack_squares, :width, :height, :currently_selected, :on_board, :raw_chars]
  
  # This rack layout drives the entire set of pieces.
  # It is parsed to find the location and shape of each piece.
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
    # Remove the borders, leaving just the set of rack pieces.
    rack_lines = @rack
      |> String.split(~r/\n/, trim: true)
      |> Enum.reject(fn line -> String.match?(line, ~r/\+-+\+/) end)
      |> Enum.map(fn line -> String.replace(line, ~r/^ *\|/, "") end)
      |> Enum.map(fn line -> String.replace(line, ~r/\|.*$/, "") end)
    raw_chars = rack_lines
      |> Enum.join
      |> String.split(~r//, trim: true)

    # Track the locations of each individual square that makes up each piece.
    # Note that the indexes for some squares happen to match printable
    # characters so the list of arrays appears to contain random text.
    rack_squares = raw_chars
      |> Enum.with_index
      |> Enum.reduce(%{},
           fn({char, index}, acc) ->
            case {char, acc[char]} do
              {" ", _} -> acc
              {_, nil} -> put_in(acc, [char], [index])
              {_, value} -> put_in(acc, [char], [index | value])
            end
          end)
          
    height = Enum.count(rack_lines)
    width = Kernel.trunc( Enum.count(raw_chars) / height )

    %__MODULE__{
      width: width,
      height: height,
      rack_squares: rack_squares,
      currently_selected: nil,
      raw_chars: raw_chars,
      on_board: %{} # each key will be the piece ID; the values are the locations on the board.
    }
  end
  
  # TODO: enhance this method or get rid of it
  def click(%TileRack{ raw_chars: raw_chars, width: width}, x, y) do
    ~s(phx-click=rack-click)
  end

  def value(%TileRack{ raw_chars: raw_chars, width: width}, x, y) do
    square_index = x + y * width
    case Enum.at(raw_chars, square_index) do
      nil -> ~s(phx-value=".")
      value -> ~s(phx-value="#{ value }")
    end
  end

  # Return the CSS class(es) that should be applied to this square.
  # Simple case: the default rack.
  def square_class(%TileRack{ raw_chars: raw_chars,
                            on_board: %{},
                            currently_selected: nil,
                            width: width
                          }, x, y) do
    square_index = x + y * width
    case Enum.at(raw_chars, square_index) do
      " " -> "" # blank
      nil -> "bad" # blank
      _ -> "piece-square" # some portion of a piece
    end
  end
  # Return the CSS class(es) that should be applied to this square.
  # Less simple case: something selected, but nothing on board.
  def square_class(%TileRack{ raw_chars: raw_chars,
                            on_board: %{},
                            currently_selected: currently_selected,
                            width: width
                          }, x, y) do
    square_index = x + y * width
    case {Enum.at(raw_chars, square_index), currently_selected} do
      {ch, ch} -> "selected-piece" # highlight the selected piece
      {" ", _} -> "" # blank
      {_a, _b} -> "piece-square" # some portion of a piece
    end
  end
  
  def column_ids(%__MODULE__{width: width}) do
    (0..(width - 1))
  end
  
  def row_ids(%__MODULE__{height: height}) do
    (0..(height - 1))
  end
end
