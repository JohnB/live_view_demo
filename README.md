# Pentomino Game

The _goal_ is a game that is multi-player and muti-board and uses
  a specific set of unique shapes, built from all permuations 
  of 1 to 5 squares. 
  These shapes are sometimes referred to generically as "pentominos".

## Status 2019/9/27
* Games can be started, and pieces selected, but not yet placed on the board.

## Roadmap
* [ ] Allow the piece to be placed on the board (and only on the board).
* [ ] Show the piece "hovering" over the board
* [ ] Add flipping and rotations before final placement.
* [ ] Define the rule structure: turns, valid moves, how the game ends.
* [ ] Spin up a new game for every 4 connections.
* [ ] Add a practice mode for when waiting for a 4th player.
* [ ] *Persist* game state and reload it on restart.

## Phoenix Phrenzy
This is my entry in [Phoenix Phrenzy](https://phoenixphrenzy.com), 
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

### Licensing
* UI controls for flipping and rotating from 
[Google's material design icons](https://github.com/google/material-design-icons/)
(Apache 2 license).
* Cross-hatch overlays were from the apparently license-free
[TransparentPNG site](http://www.transparentpng.com)
