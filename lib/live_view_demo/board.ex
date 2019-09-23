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
      nil -> [board_squares[square_index].base]
      color -> [color]
    end
  end
end
