defmodule LiveViewDemoWeb.BoardLive do
  use Phoenix.LiveView
  import Board
  import Pieces
  import Calendar.Strftime

  def render(assigns) do
    ~L"""
      <style>
        .board<%= @board.width %> span {
          width: <%= 100.0 / @board.width %>%;
          padding: 0 0 <%= 100.0 / @board.width %>%;
          display: block;
          float: left;
          margin: 0;
        }
      </style>
      <span class="rack-container">
        <%= for y <- Pieces.row_ids(@rack) do %>
          <%= for x <- Pieces.column_ids(@rack) do %>
            <a href="#"
              <%= Pieces.click(@rack, x, y) %>
              <%= Pieces.value(@rack, x, y) %>
              class="<%= Pieces.square_class(@rack, x, y) %>"
            ></a>
          <% end %>
        <% end %>
      </span>

      <span class="board-container board<%= @board.width %>">
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
          at <%= strftime!(@date, "%S") %>
        </h2>
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
    piece_index = String.at(value, 1)
    # piece_hash = %{piece_index => Piece.on_board(piece_index)
    #rack = %Pieces{rack | currently_selected: piece_hash}
    
    rack = %Pieces{rack | currently_selected: piece_index}
    board = %Board{board | pieces: rack}

    IO.puts value
    IO.puts inspect(board)
    {:noreply, assign(socket, board: board, rack: rack, date: :calendar.local_time())}
  end

  defp put_date(socket) do
    assign(socket, date: :calendar.local_time())
  end
end
