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

  def mount(session, socket) do
#    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    %{"game_id" => game_id} = session.path_params
    game = PentominoArcade.find_game(game_id)
    {:ok, assign(socket, board: game.board, rack: game.board.pieces)}
  end
  
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
    %{rack: rack, board: board} = socket.assigns
    piece_index = String.at(value, 1)
    
    rack = %Pieces{rack | currently_selected: piece_index}
    board = %Board{board | pieces: rack}
    # TODO: show the piece on the board
#    IO.puts inspect(board)

    {:noreply, assign(socket, board: board, rack: rack)}
  end

  def handle_event(event, value, socket) do
    IO.puts("DEFAULT handle_event(#{event}, #{value}...).")
    {:noreply, socket}
  end
end
