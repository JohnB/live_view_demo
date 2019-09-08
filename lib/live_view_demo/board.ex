defmodule Board do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc """
  Encapsulate the board position structure, which informs the BoardLive
  UI component.
"""
  defstruct [:board_squares, :width, :height, :start_squares, :pieces]

  def new( width \\ default_width(), height \\ default_height(), _start_style \\ :corners) do
    %__MODULE__{
      width: width,
      height: height,
      start_squares: %{
        top_left_index(width, height) => "red",\
        top_right_index(width, height) => "yellow",
        bottom_right_index(width, height) => "green",
        bottom_left_index(width, height) => "blue"
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
        ),
      pieces: Pieces.new
    }
  end
  
  def default_width() do
    21 # Enum.random([18,19,21,22])
  end
  def default_height() do
    19 # Enum.random([18,19,21,22])
  end
  def top_left_index(_width, _height) do 0 end
  def top_right_index(width, _height) do width - 1 end
  def bottom_right_index(width, height) do width * height - 1 end
  def bottom_left_index(width, height) do width * (height - 1) end
  
  # Return the CSS class(es) that should be applied to this square.
  def square_class(%__MODULE__{start_squares: start_squares, board_squares: board_squares}, square_index) do
    case start_squares[square_index] do
      nil -> [board_squares[square_index].base]
      color -> [color]
    end
  end
end
