defmodule LiveViewDemoWeb.PentominoArcadeLive do
  use Phoenix.LiveView
  import PentominoArcade
  import LiveViewDemoWeb.BoardLive
  alias LiveViewDemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
      <button phx-click='start_or_join_game' >
        <%= PentominoArcade.call_to_action(@pentomino_arcade) %>
      </button>
      
      <span class="games-container">
        <%= for game <- PentominoArcade.current_games(@pentomino_arcade) do %>
          <%= PentominoArcade.show_game(game) %>
        <% end %>
      </span>
    """
  end

  def mount(_session, socket) do
    pentomino_arcade = PentominoArcade.new()
    {:ok, assign(socket, pentomino_arcade: pentomino_arcade)}
  end

  def handle_event("start_or_join_game", value, socket) do
    IO.puts "event: start_or_join_game"

    %{pentomino_arcade: pentomino_arcade} = socket.assigns
    game = PentominoArcade.start_or_join_game(pentomino_arcade)

    {:noreply, live_redirect(socket, to: Routes.live_path(socket, LiveViewDemoWeb.BoardLive))}
  end
end
