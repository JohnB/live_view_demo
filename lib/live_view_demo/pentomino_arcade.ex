defmodule PentominoArcade do
  use GenServer

  @moduledoc """
  Manage all the pentomino games.
"""

  defstruct [:games]

  # Client
  
  def start_link() do
    case GenServer.start_link(__MODULE__, %{}, name: {:global, __MODULE__}) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end
    
  def start_or_join_game() do
    {:ok, pid} = __MODULE__.start_link()
    GenServer.call(pid, {:start_or_join_game})
  end

  def show_game(%PentominoGame{}) do
    IO.puts "method: show_game"
  end
  
  def current_games(max_games) do
    {:ok, pid} = __MODULE__.start_link()
    IO.puts "method: current_games"
    GenServer.call(pid, {:current_games, max_games})
  end

  # Server
  def init(_init_arg) do
    {:ok, %{
      games: [],
      user_ids: [],
      reset_at: Time.utc_now
    }}
  end
  
  def handle_call({:start_or_join_game}, _, state) do
    #    Enum.find(games, fn game -> PentominoGame.needs_player?(game) end, PentominoGame.new)

    {:reply, :game, state}
  end
  
  def handle_call({:current_games, max_games}, _, state) do
    {:reply, Enum.slice(state.games, 0, max_games), state}
  end
  
end
