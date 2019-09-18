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

    """
  end

  def mount(session, socket) do
    game_id = Map.get(session.path_params, :game_id)
    game = PentominoArcade.find_game(game_id)
    case game do
      nil -> {:ok, assign(socket, board: Board.new(), rack: Pieces.new())} # TODO: figure out the correct action here
      _ -> {:ok, assign(socket, board: game.board, rack: TileRack.new())}
    end
  end

  def handle_event("click", value, socket) do
    IO.puts("Board clicked at position #{value}.")
#    PentominoGame.move_held_piece_to(game_id, value)
    {:noreply, socket}
  end

  def handle_event(event, value, socket) do
    IO.puts("DEFAULT handle_event(#{event}, #{value}...).")
    {:noreply, socket}
  end
end
