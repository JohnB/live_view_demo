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
          <image src="/images/rotate_left.png" phx-click="rotate-left" />
          <image src="/images/top_to_bottom_flip.png" phx-click="flip-top" />
          <image src="/images/side_to_side_flip.png" phx-click="flip-side" />
          <image src="/images/rotate_right.png" phx-click="rotate-right" />
          <button disabled>
            OK
          </button>
        </span>
      </span>
    """
  end

  def mount(session, socket) do
    {:ok, assign(socket, rack: TileRack.new())}
  end
  
  def handle_event("rack-click", _value = ".", socket) do
    {:noreply, socket}
  end

  def handle_event("rack-click", value, socket) do
    %{rack: rack} = socket.assigns
    piece_index = String.at(value, 1)
    
    rack = %TileRack{rack | currently_selected: piece_index}

    # TODO: show the piece on the board

    {:noreply, assign(socket, rack: rack)}
  end

  def handle_event("rotate-left", _value, socket) do
    IO.puts("handle_event(rotate-left)")
    {:noreply, socket}
  end
  def handle_event("rotate-right", _value, socket) do
    IO.puts("handle_event(rotate-right)")
    {:noreply, socket}
  end
  def handle_event("flip-top", _value, socket) do
    IO.puts("handle_event(flip-top)")
    {:noreply, socket}
  end
  def handle_event("flip-side", _value, socket) do
    IO.puts("handle_event(flip-side)")
    {:noreply, socket}
  end

  def handle_event(event, value, socket) do
    IO.puts("DEFAULT TileRackLive handle_event??(#{event}, #{value}...).")
    {:noreply, socket}
  end
end
