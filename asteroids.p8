pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--[[
  Project: Asteroids
  Author:  Carlos Rodriguez Prieto
  Version: 0.3.0
  Date:    2025-07-26
  License: MIT
  GitHub:  https://github.com/crodriguezprieto/
  
  -----------------------------------------------------------------
  asteroids type game
  - spaceship: sprite 1, centered, turns on itself.
  - rocks: sprites 2 and 3, spawned from outside screen, random direction.
  - bullets: sprite 4, 10 bullets every second.
  - lives: 3, you lose each one after hitting a rock.
  - states: menu, cooldown, gameplay, game over.
--]]

-- init function
function _init()
  version = "0.3.0"
  rocks = {}
  bullets = {}
  
  -- spaceship
  player = {
    x = 64,
    y = 64,
    spr = 1,       -- sprite
    ang = -3.14/2, -- initial angle (pointing upwards)
    spd = 10,      -- bullet speed
    lives = 3,
    shoot_timer = 0
  }
  
  score = 0
  game_state = "menu"
  menu_option = 1 -- 1: start, 2: exit
end

-- reset game function
function reset_game()
  -- rocks and bullets reset
  rocks = {}
  bullets = {}
  
  -- player reset
  player.lives = 3
  player.ang = -3.14/2
  score = 0
  
  -- cooldown init
  cooldown_timer = 5
  game_state = "cooldown"
end

-- calculates the angle towards point 2
function get_angle(x1, y1, x2, y2)
  return atan2(x2 - x1, y2 - y1)
end

-- spawn rock function
function spawn_rock()
  local rock = {
    r = 4 -- hitbox radius of a rock
  }
  
  -- random sprite for any rock
  if rnd(1) > 0.5 then
    rock.spr = 2 -- blue rock
  else
    rock.spr = 3 -- red rock
  end
  
  -- spawns from off-screen
  local side = flr(rnd(4))
  if side == 0 then -- from above
    rock.x = rnd(128)
    rock.y = -8
  elseif side == 1 then -- from the right
    rock.x = 136
    rock.y = rnd(128)
  elseif side == 2 then -- from below
    rock.x = rnd(128)
    rock.y = 136
  else -- from the left
    rock.x = -8
    rock.y = rnd(128)
  end
  
  -- defining two main points A and B (read notes/specification)
  local target_a = {x=0, y=64}
  local target_b = {x=127, y=64}
  
  -- calculates both directions towards point A and point B, generating a cone
  local ang1 = get_angle(rock.x, rock.y, target_a.x, target_a.y)
  local ang2 = get_angle(rock.x, rock.y, target_b.x, target_b.y)
  
  -- choosing a random angle INSIDE this cone
  -- this logic assures it works even if the angles cross the 0|1 point (read notes/specification)
  local diff = ang2 - ang1
  if diff > 0.5 then diff -= 1 end
  if diff < -0.5 then diff += 1 end
  
  local final_ang = ang1 + rnd(diff)
  
  -- 4. applies the angle and random speed
  local spd = 0.5 + rnd(1) -- random speed between 0 and 0.99
  rock.dx = cos(final_ang) * spd
  rock.dy = sin(final_ang) * spd
  
  add(rocks, rock)
end

-- main update loop (exec 30 times/sec)
function _update()
  if game_state == "menu" then
    update_menu()
  elseif game_state == "cooldown" then
    update_cooldown()
  elseif game_state == "game" then
    update_game()
  elseif game_state == "game_over" then
    update_game_over()
  end
end

-- main drawing loop
function _draw()
  cls() -- cleans screen
  
  if game_state == "menu" then
    draw_menu()
  elseif game_state == "cooldown" then
    draw_cooldown()
  elseif game_state == "game" then
    draw_game()
  elseif game_state == "game_over" then
    draw_game_over()
  end
end


-- =============================================
--  logic and drawing of each state of the game
-- =============================================

-- state: menu
function update_menu()
  if btnp(2) or btnp(3) then -- arrows up or down
    menu_option = 3 - menu_option -- change between 1 and 2
  end
  
  if btnp(5) then -- button x
    if menu_option == 1 then
      reset_game() -- starts the game
    else
      stop() -- closes the game
    end
  end
end

function draw_menu()
  print("asteroids "..version, 34, 40, 7)
  
  -- start option
  local start_color = 7
  if menu_option == 1 then start_color = 8 end
  print("start", 53, 60, start_color)
  
  -- exit option
  local exit_color = 7
  if menu_option == 2 then exit_color = 8 end
  print("exit", 56, 70, exit_color)
end

-- state: cooldown
function update_cooldown()
  cooldown_timer -= 1/30 -- subtract a frametime
  if cooldown_timer <= 0 then
    game_state = "game"
    
    -- 10 init rocks spawn
    for i = 1, 10 do
      spawn_rock()
    end
    
    -- timer start for the continuous spawn
    spawn_timer = 1
  end
end

function draw_cooldown()
  -- draws the ship
  spr(player.spr, player.x-4, player.y-4)
  
  -- draws init cooldown
  local num = flr(cooldown_timer) + 1
  print(num, 62, 40, 8)
end

-- state: gameplay
function update_game()
  -- 1. updates player (spin and shoot)
  if btn(0) then player.ang -= 0.05 end -- spins left
  if btn(1) then player.ang += 0.05 end -- spins right
  
  player.shoot_timer -= 1/30
  if btn(5) and player.shoot_timer <= 0 then -- button x
    -- rate of fire of 10 shots per sec (1 shot every 3 frames)
    player.shoot_timer = 3/30
    
    local bullet = {
      x = player.x + cos(player.ang)*4, -- 4 pixels ahead of the ship
      y = player.y + sin(player.ang)*4,
      dx = cos(player.ang) * player.spd, -- next position. (+speed <--> -sprites) and less time to go off-screen
      dy = sin(player.ang) * player.spd,
      spr = 4,
      r = 2 -- hitbox radius
    }
    add(bullets, bullet)
  end

  -- 2. updating bullets
  for b in all(bullets) do
    b.x += b.dx
    b.y += b.dy
    -- deleting bullets if went off screen
    if b.x<-8 or b.x>136 or b.y<-8 or b.y>136 then
      del(bullets, b)
    end
  end
  
  -- 3. updating rocks
  for r in all(rocks) do
    r.x += r.dx
    r.y += r.dy
    if r.x<-8 or r.x>136 or r.y<-8 or r.y>136 then
      del(rocks, r)
    end
  end

  -- 4. collisions
  -- bullets and rocks collision
  for b in all(bullets) do
    for r in all(rocks) do
      local dist_sq = (b.x-r.x)^2 + (b.y-r.y)^2
      if dist_sq < (b.r+r.r)^2 then
        score += 10 -- add 10 points per rock hit
        del(bullets,b)
        del(rocks,r)
        
        -- future update: add sound effect and animation
        -- sfx(0)
      end
    end
  end
  
  -- player and rocks collision
  for r in all(rocks) do
    local dist_sq = (player.x-r.x)^2 + (player.y-r.y)^2 -- (a² + b² = c²)
    if dist_sq < (4+r.r)^2 then -- player radius is 4 atm
      player.lives -= 1
      del(rocks, r) -- delete rock that hit us
      
      -- future update: add sound effect and animation
      -- sfx(0)
      
      if player.lives <= 0 then
        game_state = "game_over"
      end
    end
  end
  
  -- 5. rock spawn
  spawn_timer -= 1/30
  if spawn_timer <= 0 then
    -- spawns between 1 and 2 rocks every second
    local num_to_spawn = 1 + flr(rnd(2)) -- rnd(2) top number 1.9999, never 2
    
    for i=1, num_to_spawn do
      spawn_rock()
    end
    
    spawn_timer = 1 -- reset timer to 1 sec
  end
end

function draw_game()
  -- draws spaceship with a trick, pico-8 selects the first pixel on the left top corner
  -- but we declared the center (x,y) when created the player, so we need to abstract 4 pixels
  -- from each coordenate for pico-8 to perfectly draw our player. Same later with rocks.
  spr(player.spr, player.x-4, player.y-4)
  -- draws provisional "cannon" to watch the aim direction, 8 is de line size
  line(player.x, player.y, player.x + cos(player.ang)*8, player.y + sin(player.ang)*8, 7)
  
  -- draws bullets
  for b in all(bullets) do
    spr(b.spr, b.x-2, b.y-2)
  end
  
  -- draws rocks
  for r in all(rocks) do
    spr(r.spr, r.x-4, r.y-4)
  end
  
  -- draws HUD
  -- draws dynamic lives (left)
  print("lives:", 2, 2, 7) -- (2, 2) to make room
  for i=1, player.lives do
    spr(5, 34 + (i-1)*9, 1) -- draws heart shape sprite (id = 5) for each live the player has and draws each heart 9 pixels to the right of previous heart 
  end
  
  -- draws dynamic score (right)
  local score_str = tostr(score)
  local score_width = #score_str * 4 -- each char width is 4 pixels
  -- abstracts score width to the final position to right align it
  print(score_str, 126 - score_width, 2, 7)
end

-- estado: game over
function update_game_over()
  if btnp(5) then
    game_state = "menu"
  end
end

function draw_game_over()
  print("game over", 48, 50, 8)
  print("score: "..score, 45, 60, 7)
  print("press o to continue", 25, 80, 7)
end
__gfx__
00000000000880000111110008888800000000000880088000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000177711088777880000770002888877800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770001115571188866788000770002888887800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777001111157188888678000000002888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000037777301111117188888878000000000288888000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000037777301111111188888888000000000028880000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777000111111008888880000000000002800000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000011110000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001170000740007400174001740017400274002740037400474004740057400674008740097400b7400d7401074014740197401f740277402d7402f740191401b1501d1501f1502115023150241502515026150
002902002c0502f0500d0500d0500d0500d0500d0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0500d0500f0500f0500f0500f0500f0500a0500c0500d0500f05019050
