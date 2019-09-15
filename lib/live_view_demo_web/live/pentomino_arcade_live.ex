defmodule LiveViewDemoWeb.PentominoArcadeLive do
  use Phoenix.LiveView
#  import PentominoArcade
#  import LiveViewDemoWeb.BoardLive
  alias LiveViewDemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
      <button phx-click='start_or_join_game' >
        PLAY
      </button>
      
      <span class="games-container">
        <%= for game <- PentominoArcade.current_games(4) do %>
          <%= PentominoArcade.show_game(game) %>
        <% end %>
      </span>
    """
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_event("start_or_join_game", _value, socket) do
    IO.puts "event: start_or_join_game"
    IO.puts socket.id

    _game = PentominoArcade.start_or_join_game()

    {:noreply, live_redirect(socket, to: Routes.live_path(socket, LiveViewDemoWeb.BoardLive))}
  end
end
