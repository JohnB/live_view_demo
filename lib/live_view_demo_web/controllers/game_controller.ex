defmodule LiveViewDemoWeb.GameController do
  use LiveViewDemoWeb, :controller

  def play(conn, params) do
    render(conn, "play.html", %{game_id: params["game_id"]})
  end
end
