defmodule PentominoArcade do
  use GenServer

  @moduledoc """
  Manage all the pentomino games in a GenServer.
  
  Keep track of all the games and users.
  Games will track the board, the players, and the
  player's tile racks.
"""

  defstruct [:games, :user_ids, :tile_racks]

  # Client
  
  def start_link() do
    case GenServer.start_link(__MODULE__, %{}, name: {:global, __MODULE__}) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end
    
  def start_or_join_game(player_id) do
    {:ok, pid} = __MODULE__.start_link()
    GenServer.call(pid, {:start_or_join_game, player_id})
  end

  def find_game(game_id) do
    {:ok, pid} = __MODULE__.start_link()
    GenServer.call(pid, {:find_game, game_id})
  end
    
  def current_games(max_games) do
    {:ok, pid} = __MODULE__.start_link()
    GenServer.call(pid, {:current_games, max_games})
  end

  # Server
  def init(_init_arg) do
    {:ok, %__MODULE__{
      games: [],
      user_ids: [],
      tile_racks: []
    }}
  end
  
  def handle_call({:start_or_join_game, player_id}, _, state = %{games: games}) do
    case Enum.find(games, fn game -> PentominoGame.needs_player?(game) end) do
      nil -> start_a_new_game(state, player_id)
      game -> join_game(state, game, player_id)
    end
  end
  
  def handle_call({:find_game, game_id}, _, state) do
    selected_game = Enum.find(state.games, fn g -> g.id == game_id end)
     IO.puts "Found game #{game_id}: #{inspect(selected_game)}"
    {:reply, selected_game, state}
  end
  
  def handle_call({:current_games, max_games}, _, state) do
    {:reply, Enum.slice(state.games, 0, max_games), state}
  end
  
  def start_a_new_game(state = %{games: games}, player_id) do
    new_game = PentominoGame.new(player_id)
    {:reply, new_game, %{state | games: games ++ [new_game]}}
  end
  
  def join_game(state = %{games: games}, game_to_join, player_id) do
    updated_game = PentominoGame.add_player(game_to_join, player_id)
    updated_games = Enum.map(games, fn game ->
      case {game.id, updated_game.id} do
        {a, a} -> updated_game
        _ -> game
      end
    end )
    
    {:reply, updated_game, %{state | games: updated_games}}
  end
  
end
