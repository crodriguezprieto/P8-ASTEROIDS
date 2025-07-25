# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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