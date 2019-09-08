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
  
## Bottlenecks
### 9019-09-07: Data Modeling Goofs
Maybe the lack of persistence allows me to rush too quickly. 
In my haste I've created some awkward internal data cleavings -
but I think they're fixable. 
I'm looking forward to refactoring as I go. I have a sense it will
be even easier than ruby, once I get the hang of it.

### 9019-09-07: Deployment Sorrows
I have misconfigured something on Heroku such that socket connections
appear to be coming from the wrong domain and are being rejected 
(correctly, I think, since we should _not_ accept sockets from other
domains - but I don't see where it is misconfigured). I'll sort it
with support soon 
(and plan to _pay_ them for a dyno or two - well worth it).

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
