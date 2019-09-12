# Pentomino Game

The _goal_ is a game that is multi-player and muti-board and uses
  a specific set of unique shapes, built from all permuations 
  of 1 to 5 squares. 
  These shapes are sometimes referred to generically as "pentominos".

## The Use of LiveView
The fact that the server is explicitly "stateful" means 
that I can experiment with the UI without having to design the
 eventual persistence layer. This, and the lack of any time spent on
 tests, has allowed me to iterate incredibly quickly on the UI.
  
## Roadmap
As of 9019-09-07 (not necessarily in order):
* [x] Allow selecting a piece in the rack, making it disappear from the rack.
* [ ] Allow the piece to be placed on the board (and only on the board).
* [ ] Milestone: MVP for Phrenzy entry, future steps are gravy.
* [ ] Refactor so every event handler is a one-line call to a single model:
  * [ ] PentominoArcade.add_player_to_open_game(socket)
  * [ ] PieceOverBoard.pick_up(socket_assigns, piece_id)
  * [ ] PieceOverBoard.rotate(socket_assigns, direction)
  * [ ] PieceOverBoard.flip(socket_assigns, direction)
  * [ ] PieceOverBoard.place(socket_assigns)
  * [ ] PieceOverBoard.valid_placement?(socket) would enable the UI button.
* [ ] Show the piece "hovering" over the board
* [ ] Add flipping and rotations before final placement.
* [ ] Milestone: MVP for Phrenzy entry, future steps are gravy.
* [ ] Encapsulate PentominoGames and Players and Moves into genservers.
* [ ] Restructure boards and pieces to match.
* [ ] Define the rule structure: turns, valid moves, how the game ends.
* [ ] Spin up a new game for every 4 connections (how? game manager?).
* [ ] Add a practice mode for when waiting for a 4th player.
* [ ] *Persist* game state and reload it on restart.

## Learnings
### 9019-09-07: What good LiveView code looks like.
(disclaimer: the code in _this_ repo does not match my learnings yet)
* All event handlers should be a one-line call to a single model:
  * PentominoGame.needing_players(socket)
 
## Bottlenecks
### 9019-09-07: Data Modeling Goofs
Maybe the lack of persistence allows me to rush too quickly. 
In my haste I've created some awkward internal data cleavings -
but I think they're fixable. 
(this is referring to board, pieces and board_live code at commit #b1fa2cb)
I'm looking forward to refactoring as I go. I have a sense it will
be even easier than ruby, once I get the hang of it.

### SOLVED: Deployment Buildpack Ordering
I had one problem and then I fiddled with random stuff to try to fix it,
and soon had multiple problems.
One follow-on problem was that I tried switching buildpacks 
and accidentally reversed the two we need and found that order matters.
The wrong order caused builds to fail with two consistent error messages:
* `mix: command not found`
* `Push rejected, failed to compile Phoenix app.`
This was fixed by reversing the order of the buildpacks. 

Here is the correct ordering of your `heroku buildpacks` output:
```
=== shrouded-spire-77484 Buildpack URLs
1. https://github.com/HashNuke/heroku-buildpack-elixir.git
2. https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`
```

### SOLVED: Client was Unable to Connect a Websocket
This was the original socket problem, where the browser would display
the initial HTML and data and then "fuzz out" (a light gray) 
and be unresponsive.

`heroku logs` showed that the server was getting the same error
over and over again:
```
Could not check origin for Phoenix.Socket transport.
```

This was solved 
[via stackoverflow](https://stackoverflow.com/questions/43188260/how-to-fix-error-could-not-check-origin-for-phoenix-socket-transport-phoenix/43188390)
by adding this line to `onfig/prod.exs` to allow the connection:
```
check_origin: ["https://shrouded-spire-77484.herokuapp.com"]
```

## Phoenix Phrenzy
This ~is~ _will soon be_ my entry in [Phoenix Phrenzy](https://phoenixphrenzy.com), 
showing off what [Phoenix](https://phoenixframework.org/) and 
[LiveView](https://github.com/phoenixframework/phoenix_live_view) can do.

![https://shrouded-spire-77484.herokuapp.com/](assets/static/images/preview.gif "Pentomino Game")

# Phrenzy Instructions

Fork this repo and start build an application! See [Phoenix Phrenzy](https://phoenixphrenzy.com) for details.


## The Usual README Content

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
###
