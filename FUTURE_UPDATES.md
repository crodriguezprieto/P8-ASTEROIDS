# Future updates and ideas

### Visual changes
- **Animations:** Create animations for everything: destroyed rock, destroyed spaceship, game over cinematic.
- **Lives:** Show lives as single heart sprites instead of the number of lives.
- **HP:** Show some kind of hp bar, maybe on the far top right
- **Better Score:** Right now it slides outside the screen if the number is too big. Maybe locate the score to the far bottom left.
- **Animations:** Show lives as single heart sprites instead of the number of lives.

### New Features
- **Entire sound pallet:** Including background sound, when shooting, when hit a rock, when spaceship explodes (background sound end), game over sound (after spaceship exploded animation), switch between menu selects sound.
- **Main menu Settings:** Add an Settings entry on the main menu: Change spaceship colour, Change dificulty.
- **Score summary when game over:** Detailed summary when game is over: How many rocks you broke, how many shots shot, accuraccy ratio, time on the game (including all lives f.example)
- **Nightmare mode** All rocks aim towards the player.
- **Heart asteroids** Random spawn of heart shape like asteroids, destroying it gives the player a extra live.
- **Powerups** Random spawn of powerups, shooting it gives the player the powerup: a shield that destroys incoming asteroids, dual shots, etc.


### Logic changes/add
- **HP system:** Right now the spaceship has 3 lives and we're subtracting 1 life everytime a rock hit us. When there's no lifes left game over screen appears. Maybe code some hp system in which everytime a rock hit the spaceship it loses 10 hp. When 3 rocks hit us it's 1 life less. New screen showing Continue?. Score keeps keeping data until no lifes left and then Score summary screen.