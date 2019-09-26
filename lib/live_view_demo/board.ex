defmodule Board do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc """
  Encapsulate the board position structure, which informs the BoardLive
  UI component.
"""
  defstruct [:board_squares, :width, :height, :start_squares]
  @player_colors ["blue", "green", "yellow", "red"]

  def new( width \\ default_width(), height \\ default_height(), _start_style \\ :corners) do
    # Randomize our start squares w/in the corner quadrant
    top_left_x = Enum.random([0, 1, 2, 3])
    top_left_y = Enum.random([0, 1, 2, 3])
    top_left = width * top_left_y + top_left_x
    top_right = width * (top_left_x + 1) - top_left_y - 1
    bot_right = width * height - top_left - 1
    bot_left = width * height - top_right - 1
    
    %__MODULE__{
      width: width,
      height: height,
      start_squares: %{
        top_left => Enum.at(@player_colors, 0),
        top_right => Enum.at(@player_colors, 1),
        bot_right => Enum.at(@player_colors, 2),
        bot_left => Enum.at(@player_colors, 3)
      },
      board_squares:
        Enum.reduce( 1..(width * height), %{},
          fn x, acc -> put_in(acc, [x-1],
            %{
              base: "", # in
              overlay: nil,
              square: x-1
            }
          )
          end
        )
    }
  end
  
  def default_width() do
    Enum.random([18,19,21,22])
  end
  def default_height() do
    20 # consistent height looks better on mobile than Enum.random([18,19,21,22])
  end
  
  # Return the CSS class(es) that should be applied to this square.
  def square_class(%__MODULE__{start_squares: start_squares, board_squares: board_squares}, square_index) do
    case start_squares[square_index] do
      nil -> ["#{board_squares[square_index].base} #{board_squares[square_index].overlay}"]
      color -> [color]
    end
  end
  
  def show_on_board(board, five_squares, position, class) do
    five_squares = smear(five_squares, board.width)
      |> Enum.map(fn n -> n + position end)
    updated_squares = board.board_squares
      |> Enum.map(fn {k, v} ->
        case Enum.member?(five_squares, k) do
          true -> {k, %{v | overlay: class}}
          _ -> {k, v}
        end end)
    %{board | board_squares: updated_squares}
  end
  
  # shift these squares to the upper left of a grid of src_width to a grid of dest_width
  def smear(squares, width) do
    Enum.map(squares, fn n -> Integer.mod(n, 5) + width * Integer.floor_div(n, 5) end)
  end
  
  # shift these squares to the upper left of a grid of src_width to a grid of dest_width
  def snug(squares, src_width \\ 5, dest_width \\ 5) do
    IO.puts(inspect(squares))
    min_x = squares
      |> Enum.map(fn position -> Integer.mod(position, src_width) end)
      |> Enum.min()
    min_y = squares
      |> Enum.map(fn position -> Integer.floor_div(position, src_width) end)
      |> Enum.min()
    shifted_left = Enum.map(squares, fn position -> position - min_x end)
    Enum.map(shifted_left, fn position ->
      Integer.mod(position, src_width) +
      (Integer.floor_div(position, src_width) - min_y) * dest_width
    end)
  end
end
