defmodule LiveViewDemoWeb.PentominoArcadeLive do
  use Phoenix.LiveView
  alias LiveViewDemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
      <span phx-click=start_or_join_game >
        <button>
          PLAY
        </button>
      </span >
      <br />
      <span class="games-container">
        <%= for game <- PentominoArcade.current_games(4) do %>
          <%= PentominoArcade.show_game(game) %>
          <br />
        <% end %>
      </span>
    """
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

   def handle_event("start_or_join_game", _value, socket) do
     player_id = socket.id # use the socket as a proxy to the player (until we add proper user mgmt)
     game = PentominoArcade.start_or_join_game(player_id)

     {:noreply, live_redirect(assign(socket, :game_id, game.id), to: Routes.live_path(socket, LiveViewDemoWeb.BoardLive, game.id))}
   end
end
