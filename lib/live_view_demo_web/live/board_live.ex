defmodule LiveViewDemoWeb.BoardLive do
  use Phoenix.LiveView
#  import Board
  import Calendar.Strftime

  def render(assigns) do
    ~L"""
      <style>
      </style>
      <span class="rack-container">
        <%= for y <- Pieces.row_ids(@rack) do %>
          <%= for x <- Pieces.column_ids(@rack) do %>
            <span
              <%= Pieces.click(@rack, x, y) %>
              <%= Pieces.value(@rack, x, y) %>
              class="<%= Pieces.square_class(@rack, x, y) %>"
            ></span>
          <% end %>
        <% end %>
      </span>

      <span class="board-container board20">
        <%= for {_square, index} <- Enum.with_index(@board.board_squares) do %>
          <span
            phx-click="click"
            phx-value="<%= index %>"
            class="<%= Board.square_class(@board, index) %>"
          ></span>
        <% end %>
      </span>

      <div>
        <h2 phx-click="boom">
          <%= @board.width %>x<%= @board.height %>
          (<%= @board.width %>x<%= @board.height %>)
          at <%= strftime!(@date, "%S") %><
        /h2>
      </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    board = Board.new()
    {:ok, assign(socket, board: board, rack: board.pieces, date: :calendar.local_time())}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_date(socket)}
  end

  def handle_event("\"rack-click\"", value, socket) do
    %{rack: rack, board: board} = socket.assigns
    rack = %Pieces{rack | currently_selected: String.at(value, 1)}
    board = %Board{board | pieces: rack}

    IO.puts value
    IO.puts inspect(board)
    {:noreply, assign(socket, board: board, rack: rack, date: :calendar.local_time())}
  end

  defp put_date(socket) do
    assign(socket, date: :calendar.local_time())
  end
end
