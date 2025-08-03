# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.7.0] - 2025-07-03

### Added
- **Bigger rocks:** New 16x16 rock type added (10% spawn rate). It has the ability to split itself in 2 8x8 pieces when destroyed.
- **Triple fire rate rocks:** New 8x8 rock type added (5% spawn rate). When destroyed, two more fire rates spawn for 10 seconds.
- **TODO Shield up rocks:** New 8x8 rock type added (5% spawn rate). Protects the player against one rock or big rock, then it dissapears.
- **Heal up rocks:** New 8x8 heart rock type added (5% spawn rate). When destroyed or collisioned, it gives the player an extra heart if lives < 5.
- **Ultimate move:** New 8x8 rock type added (1/100 spawn rate). When destroyed, it doubles the player's firerate for 15 seconds.

### Changed
- **Changed file name:** Renamed DESIGN_SPEC to TECHNICAL_DOCUMENTATION.

## [0.6.0] - 2025-07-30

### Added
- **New credits:** Set credits as an option in the main menu and filled with cheerful message and played around with some tricks with colours in texts.

## [0.5.0] - 2025-07-28

### Added
- **New spaceship sprites:** Added 4 new spaceships to choose from.
- **Design specifications:** New entry for the rotation algorythm explained and reviewed some texts.
- **New game logo:** Added custom game logo from several sprites showing the name of the game.
- **New menu design and new entries:** New entries added: settings and credits. Credits show author's name. Version now added to the bottom left of the main menu.
- **New spaceship select function:** Now when the player starts a new game it has to choose the spaceship to play with.

## [0.4.0] - 2025-07-28

### Added

- **Rotation Function:** Added a function to rotate the spaceship sprite when turning on itself based on Standard 2D Rotation Matrix: Implements pixel‑level sprite rotation by applying the classical 2×2 rotation matrix (x′ = x·cosθ − y·sinθ, y′ = x·sinθ + y·cosθ) around the sprite center.
- **Three New Ship Sprites:** Added three new ship sprites for additional visual variety.
- **DEBUG_CODE:** Added legacy DEBUG_CODE doc for extra code used to debug key features.

## [0.3.1] - 2025-07-27

### Changed

- **New Background:** Implemented new background with 4 different types of stars.
- **New Bullet Sprite:** Created new fancy bullet sprite.
- **New control direction:** Inverted controls, now it feels right.
- **Low bullet speed:** It was on drugs on previous versions.

## [0.3.0] - 2025-07-26

### Added

- **New Heart Sprite:** Created and implemented a heart sprite for the new graphical lives display.

### Changed

- **Major HUD Overhaul:** The in-game Heads-Up Display has been completely redesigned for a cleaner and more professional look.
    - **Graphical Lives Display:** The previous numerical lives counter (`LIVES: 3`) has been replaced with a graphical representation. The game now draws one heart sprite for each life the player has remaining.
    - **Dynamic Score Display:** The score is now dynamically right-aligned. The "SCORE:" label has been removed for a more minimalist aesthetic, and the number will always stay visible on the right edge of the screen, regardless of its length.

### Removed

- **Old Text-Based HUD:** The previous implementation for displaying lives and score with static text labels has been removed in favor of the new dynamic system.

## [0.2.1] - 2025-07-26

### Changed

- **Improved Code Documentation:** Expanded and improved in-code comments across the codebase, providing detailed explanations for key functions and logic blocks.
- **Enhanced Code Comprehension:** Improved in-code comments to clarify core logic about the center-based coordinate system and some comments for player and spawning mechanics.
- **Comment Language:** Translated all remaining code comments from Spanish to English for international consistency and clarity.

## [0.2.0] - 2025-07-25

### Added

- **Project Documentation:** Added a comprehensive design specification document detailing core game mechanics, including the PICO-8 angle system and the targeted asteroid spawning logic.
- **Author Attribution:** Included the author's name in the source code file header.

### Changed

- **Reworked Asteroid Spawning Logic:** Completely overhauled the enemy spawning system for a more engaging and fair gameplay experience.
    - Asteroids no longer travel in a fully random direction, which previously resulted in many of them never entering the screen.
    - The new system ensures that every spawned asteroid travels towards the gameplay area.
    - It dynamically calculates a "cone" of possible trajectories aimed towards a central horizontal line on the screen. This guarantees that every asteroid is a potential threat and eliminates wasted off-screen entities.
- **Comments:** Enhanced some comments.

## [0.1.0] - 2025-07-24

### Added

- **Initial Project Creation and First Playable Version.**

- **State-Based Game Architecture:**
    - A state machine has been implemented to manage the game flow, separating logic into: `menu`, `cooldown`, `gameplay`, and `game_over`.
    - Dedicated update (`update_*`) and draw (`draw_*`) functions for each state, keeping the code organized.

- **Complete Gameplay Loop:**
    - **Main Menu:** Functional start screen with "START" (begin game) and "EXIT" (close the program using `stop()`) options. Displays the game title and version.
    - **Countdown:** A 5-second timer prepares the player for action upon starting a new game.
    - **Game Over Screen:** Appears after losing all lives, showing the final score and an option to return to the main menu.

- **Player Logic and Controls:**
    - The ship (Sprite 1) remains fixed in the center of the screen.
    - Implemented 360-degree rotational control for aiming with the arrow keys.
    - A visual line has been added as a "cannon" to clearly indicate the aiming direction.
    - 3-life system; a life is lost upon each collision with an asteroid with no continue segment.

- **Shooting System:**
    - The ship can fire projectiles (Sprite 4) using an action key.
    - A fire rate of 10 shots per second is implemented to prevent an excessive number of bullets (for now).
    - Projectiles are spawned at the tip of the ship's cannon, not at its center.

- **Enemy Logic (Asteroids):**
    - Two types of asteroids (Sprites 2 and 3) with random appearances.
    - Procedural spawning system that generates asteroids from outside the screen boundaries (top, bottom, left, right).
    - Each asteroid has a random direction and speed, creating an unpredictable challenge.
    - The game begins with an initial wave of 10 asteroids.
    - During the game, 1 to 2 new asteroids spawn continuously every second.

- **Collision System and Mechanics:**
    - Optimized circular collision detection (using squared distance) for all objects.
    - **Bullet-Asteroid:** Upon collision, both objects are removed, and the player receives 10 points.
    - **Player-Asteroid:** Upon collision, the player loses a life, and the asteroid is destroyed.

- **Optimization and Memory Management:**
    - Both bullets and asteroids that go off-screen are automatically removed. This prevents the accumulation of unseen objects and ensures stable long-term performance.

- **User Interface (HUD):**
    - During gameplay, the number of remaining lives and the player's current score are displayed on-screen.