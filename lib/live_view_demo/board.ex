defmodule Board do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc """
  Encapsulate the board position structure, which informs the BoardLive
  UI component.
"""
  defstruct [:board_squares, :width, :height, :start_squares]

  def new( width \\ 20, height \\ 20, start_style \\ :corners) do
    %__MODULE__{
      width: width,
      height: height,
      start_squares: %{
        0 => "red", # top-left
        (width - 1) => "yellow", # top-right
        (width * height - 1) => "green", # bottom-right
        (width * (height - 1)) => "blue" # bottom-left
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
end
