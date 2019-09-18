defmodule LiveViewDemoWeb.PentominoArcadeLive do
  use Phoenix.LiveView
  alias LiveViewDemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
      <span phx-click=start_or_join_game >
        <button>
          NEW GAME
        </button>
      </span >
      <h2>Games in Progress</h2>
      <span class="games-container">
        <%= for game <- PentominoArcade.current_games(4) do %>
          <%= live_render(@socket, LiveViewDemoWeb.BoardLive, session: %{path_params: %{game_id: game.id}}) %>
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

     dest = Routes.game_path(socket, :play, game.id)
     IO.puts dest
     {:noreply, redirect(socket, to: dest)}
   end
end
