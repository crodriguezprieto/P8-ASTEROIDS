# Future updates and ideas

### Visual changes
- **Animations:** Create animations for everything: destroyed rock, destroyed spaceship, game over cinematic.
- **HP:** Show some kind of hp bar, maybe on the far top right

### New Features
- **Entire sound pallet:** Including background sound, when shooting, when hit a rock, when spaceship explodes (background sound end), game over sound (after spaceship exploded animation), switch between menu selects sound.
- **New difficulty:** New setting change dificulty.
- **Score summary when game over:** Detailed summary when game is over: How many rocks you broke, how many shots shot, accuraccy ratio, time on the game (including all lives f.example)
- **Nightmare mode:** All rocks aim towards the player.
- **Heart asteroids:** Random spawn of heart shape like asteroids, destroying it gives the player a extra live.
- **Powerups:** Random spawn of powerups, shooting it gives the player the powerup: a shield that destroys incoming asteroids, dual shots, etc.
- **Score table** Enable to register your name with your total points at the end of the game.

### Logic changes/add
- **HP system:** Right now the spaceship has 3 lives and we're subtracting 1 life everytime a rock hit us. When there's no lifes left game over screen appears. Maybe code some hp system in which everytime a rock hit the spaceship it loses 10 hp. When 3 rocks hit us it's 1 life less. New screen showing Continue?. Score keeps keeping data until no lifes left and then Score summary screen.
- **Ammo system:** Right now there's no punishment on holding the trigger constantly. Make "limited" ammo. If you hold the trigger ammo will decrease, but it restores itself overtime if you stop shooting, that way the game punishes us for holding the trigger too much time. If you only shoot single shots ammo doesn't decrease.