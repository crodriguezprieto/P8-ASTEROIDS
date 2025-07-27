

function draw_game()
  -- draws map
  map(0, 0, 0, 0, 16, 16)

  -- draws ship
  spr_r(player.spr, player.x, player.y, player.ang, 4, 4)

  -- DEBUG: ship's center and tip 
  -- local t  = player.ang / 360
  -- local ca, sa = cos(t), sin(t)
  -- local cx, cy = player.x+16, player.y+16
  -- local tipx = cx + ca*8
  -- local tipy = cy - sa*8
  -- pset(cx,   cy,   8)  -- ship center drawn in red
  -- pset(tipx, tipy, 9)  -- ship tip draw in yellow
  -- END DEBUG


  -- draws bullets
  for b in all(bullets) do
    spr(b.spr, b.x, b.y)
    -- -- DEBUG: bullet's center
    -- pset(flr(b.x), flr(b.y), 8)
    -- local sx, sy = flr(b.x)+4, flr(b.y)-6
    -- print(flr(b.x)..","..flr(b.y), sx, sy, 7)
    -- -- END DEBUG
  end
end