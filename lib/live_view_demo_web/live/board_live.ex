defmodule LiveViewDemoWeb.BoardLive do
  use Phoenix.LiveView
  import Board
  import Calendar.Strftime

  def render(assigns) do
    ~L"""
      <table class="board">
        <%= for y <- 0..(@board.width - 1) do %>
          <tr>
          <%= for x <- 0..(@board.height - 1) do %>
            <td class="<%= @board.board_squares[@board.width * y + x].base %>">
              <%= @board.width * y + x %>
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
      
    <div>
      <h2 phx-click="boom">It's <%= strftime!(@date, "%S") %></h2>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, assign(socket, board: Board.new(), date: :calendar.local_time())}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_date(socket)}
  end

  defp put_date(socket) do
    assign(socket, date: :calendar.local_time())
  end
end
