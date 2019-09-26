defmodule LiveViewDemoWeb.TileRackLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
      <span class="rack-container">
        <%= for y <- TileRack.row_ids(@rack) do %>
          <%= for x <- TileRack.column_ids(@rack) do %>
            <a href="#"
              <%= TileRack.click(@rack, x, y) %>
              <%= TileRack.value(@rack, x, y) %>
              class="<%= TileRack.square_class(@rack, x, y) %>"
            ></a>
          <% end %>
        <% end %>
        <span class="rack-controls">
          <image src="/images/rotate_left.png"        phx-click="rotate-left" />
          <image src="/images/top_to_bottom_flip.png" phx-click="flip-top" />
          <image src="/images/side_to_side_flip.png"  phx-click="flip-side" />
          <image src="/images/rotate_right.png"       phx-click="rotate-right" />
          <button phx-click="finish-move">
            OK
          </button>
        </span>
      </span>
    """
  end

  def mount(session, socket) do
    player_id = socket.id # use the socket as a proxy to the player (until we add proper user mgmt)
    
    case get_in(session, [:game_id]) do
      nil -> {:ok, assign(socket, rack: TileRack.new(), game_id: 8675309, player_id: player_id)}
      game_id -> {:ok, assign(socket, rack: TileRack.new(), game_id: game_id, player_id: player_id)}
    end
  end
  
  def handle_event("rack-click", _value = ".", socket) do
    {:noreply, socket}
  end

  def handle_event("rack-click", value, socket) do
    %{rack: rack, game_id: game_id, player_id: player_id} = socket.assigns
    piece_index = String.at(value, 1)
    
    rack = %TileRack{rack | currently_selected: piece_index}

    rack_squares = rack.rack_squares[piece_index] |> Board.snug(rack.width)
    PentominoGame.pick_up_piece(game_id, player_id, piece_index, rack_squares)

    {:noreply, assign(socket, rack: rack)}
  end

  def handle_event("rotate-left", _value, socket) do
    IO.puts("handle_event(rotate-left)")
#    PentominoGame.rotate_left_held_piece(game_id, player_id)
    {:noreply, socket}
  end
  def handle_event("rotate-right", _value, socket) do
    IO.puts("handle_event(rotate-right)")
#    PentominoGame.rotate_right_held_piece(game_id, player_id)
    {:noreply, socket}
  end
  def handle_event("flip-top", _value, socket) do
    IO.puts("handle_event(flip-top)")
#    PentominoGame.vertical_flip_held_piece(game_id, player_id)
    {:noreply, socket}
  end
  def handle_event("flip-side", _value, socket) do
    IO.puts("handle_event(flip-side)")
#    PentominoGame.horizontal_flip_held_piece(game_id, player_id)
    {:noreply, socket}
  end
  def handle_event("finish-move", _value, socket) do
    IO.puts("handle_event(finish-move)")
#    PentominoGame.finish_move(game_id, player_id)
    {:noreply, socket}
  end

  def handle_event(event, value, socket) do
    IO.puts("DEFAULT TileRackLive handle_event??(#{event}, #{value}...).")
    {:noreply, socket}
  end
end
