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

### Logic changes/add
- **Rock direction:** Focus the rock direction on concrete angles. Right now the route is random, so if a rock spawns behind the left of the screen, the rock's direction could be directed to the left or top as well, that way we never get to see the rock. That's a big problem. If a rock spawns on the left the direction should always be focused to the contrary side. Maybe setting an angle between 30º and 330º (if the rock spawns on the left) at list that way we actually see the rock even if the angle is very near to the min and max.
- **HP system:** Right now the spaceship has 3 lives and we're subtracting 1 life everytime a rock hit us. When there's no lifes left game over screen appears. Maybe code some hp system in which everytime a rock hit the spaceship it loses 10 hp. When 3 rocks hit us it's 1 life less. New screen showing Continue?. Score keeps keeping data until no lifes left and then Score summary screen.