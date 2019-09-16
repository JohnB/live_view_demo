defmodule LiveViewDemoWeb.BoardLive do
  use Phoenix.LiveView

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

      <span class="board-container board<%= @board.width %>">
        <%= for {_square, index} <- Enum.with_index(@board.board_squares) do %>
          <span
            phx-click="click"
            phx-value="<%= index %>"
            class="<%= Board.square_class(@board, index) %>"
          ></span>
        <% end %>
      </span>

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

    """
  end

  def mount(_session, socket) do
#    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    board = Board.new()
    {:ok, assign(socket, board: board, rack: board.pieces)}
  end
  
#  def handle_params(params, _uri, socket) do
#    game = PentominoArcade.find_game(params["game_id"])
#    IO.puts("handle_params: game=#{inspect(game)}, params=#{inspect(params)}")
#
#    case game do
#      nil -> {:error, socket}
#      game -> {:ok, assign(socket, game: game) }
#    end
#  end
  
#  def handle_info(:tick, socket) do
#    {:noreply, socket}
#  end

  def handle_event("click", value, socket) do
    IO.puts("Board clicked at position #{value}.")
    {:noreply, socket}
  end

  def handle_event("rack-click", _value = ".", socket) do
    {:noreply, socket}
  end

  def handle_event("rack-click", value, socket) do
    IO.puts "value"
    IO.puts value

    %{rack: rack, board: board} = socket.assigns
    piece_index = String.at(value, 1)
    # piece_hash = %{piece_index => Piece.on_board(piece_index)
    #rack = %Pieces{rack | currently_selected: piece_hash}
    
    rack = %Pieces{rack | currently_selected: piece_index}
    board = %Board{board | pieces: rack}
    IO.puts inspect(board)

    {:noreply, assign(socket, board: board, rack: rack)}
  end

  def handle_event(event, value, socket) do
    IO.puts("DEFAULT handle_event(#{event}, #{value}...).")
    {:noreply, socket}
  end
end
