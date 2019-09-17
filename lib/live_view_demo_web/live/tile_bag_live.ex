defmodule LiveViewDemoWeb.TileBagLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
      <span class="rack-container">
        <%= for y <- Pieces.row_ids(@rack) do %>
          <%= for x <- Pieces.column_ids(@rack) do %>
            <a href="#"
              <%= Pieces.click(@rack, x, y) %>
              <%= Pieces.value(@rack, x, y) %>
              class="<%= Pieces.square_class(@rack, x, y) %>"
            ></a>
          <% end %>
        <% end %>
      </span>

    """
  end

  def mount(session, socket) do
    {:ok, assign(socket, rack: Pieces.new())}
  end
  
  def handle_event("rack-click", _value = ".", socket) do
    {:noreply, socket}
  end

  def handle_event("rack-click", value, socket) do
    %{rack: rack} = socket.assigns
    piece_index = String.at(value, 1)
    
    rack = %Pieces{rack | currently_selected: piece_index}

    # TODO: show the piece on the board

    {:noreply, assign(socket, rack: rack)}
  end

  def handle_event(event, value, socket) do
    IO.puts("DEFAULT TileBagLive handle_event(#{event}, #{value}...).")
    {:noreply, socket}
  end
end
