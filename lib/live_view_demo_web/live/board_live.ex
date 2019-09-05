defmodule LiveViewDemoWeb.BoardLive do
  use Phoenix.LiveView
  import Board
  import Calendar.Strftime

  def render(assigns) do
    ~L"""
      <table class="game-container"><tr><td class="rack-container">
        <table class="rack">
          <%= for y <- Pieces.row_ids(@rack) do %>
            <tr>
            <%= for x <- Pieces.column_ids(@rack) do %>
              <td class="<%= Pieces.square_class(@rack, x, y) %>">
              </td>
            <% end %>
            </tr>
          <% end %>
        </table>
      </td><td class="board-container">
        <table class="board">
          <%= for y <- 0..(@board.width - 1) do %>
            <tr>
            <%= for x <- 0..(@board.height - 1) do %>
              <td class="<%= Board.square_class(@board, @board.width * y + x) %>">
              </td>
            <% end %>
            </tr>
          <% end %>
        </table>
        <table>
          <tr>
            <td>
            </td>
          </tr>
        </table>
      </td></tr></table>

      <div>
        <h2 phx-click="boom">It's <%= strftime!(@date, "%S") %></h2>
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

  defp put_date(socket) do
    assign(socket, date: :calendar.local_time())
  end
end
